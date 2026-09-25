import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:candil/theme.dart';

class BorrowedBooksPage extends StatelessWidget {
  const BorrowedBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Silakan login terlebih dahulu"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blue1,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Buku yang Dipinjam",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('peminjaman')
            .where(
              'userId',
              isEqualTo: user.uid,
            )
            .where(
              'status',
              isEqualTo: 'dipinjam',
            )
            .orderBy(
              'tanggalPinjam',
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Terjadi kesalahan:\n${snapshot.error}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Belum ada buku yang dipinjam",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          final loans = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: loans.length,
            itemBuilder: (context, index) {
              final loan = loans[index];

              final bookId = loan['bookId'];
              final tanggalPinjam = loan['tanggalPinjam'] as Timestamp;

              return _BorrowedBookCard(
                bookId: bookId,
                tanggalPinjam: tanggalPinjam.toDate(),
              );
            },
          );
        },
      ),
    );
  }
}

class _BorrowedBookCard extends StatelessWidget {
  final String bookId;
  final DateTime tanggalPinjam;

  const _BorrowedBookCard({
    required this.bookId,
    required this.tanggalPinjam,
  });

  @override
  Widget build(BuildContext context) {
    // Deadline = 7 hari setelah tanggal pinjam
    final deadline = tanggalPinjam.add(
      const Duration(days: 7),
    );

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('books').doc(bookId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade100,
            ),
            child: const SizedBox(
              height: 80,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const SizedBox();
        }

        final book = snapshot.data!.data() as Map<String, dynamic>;

        final title = book['JudulBuku'] ?? 'Judul tidak tersedia';
        final author = book['Penulis'] ?? 'Penulis tidak tersedia';

        return _buildCard(
          context,
          title,
          author,
          deadline,
        );
      },
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    String author,
    DateTime deadline,
  ) {
    final now = DateTime.now();

    final difference = deadline.difference(now);

    final isLate = difference.isNegative;

    final daysLeft = difference.inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL
          Text(
            title,
            style: bold18.copyWith(
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 5),

          // PENULIS
          Text(
            "by $author",
            style: regular14.copyWith(
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 15),

          // TANGGAL PINJAM
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                "Dipinjam: ${_formatDate(tanggalPinjam)}",
                style: regular14,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // DEADLINE
          Row(
            children: [
              Icon(
                Icons.event_available_outlined,
                size: 18,
                color: isLate ? Colors.red : blue3,
              ),
              const SizedBox(width: 8),
              Text(
                "Deadline: ${_formatDate(deadline)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isLate ? Colors.red : Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // STATUS
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: isLate
                  ? Colors.red.withOpacity(0.1)
                  : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isLate
                  ? "Terlambat ${difference.inDays.abs()} hari"
                  : daysLeft == 0
                      ? "Deadline hari ini"
                      : "Sisa $daysLeft hari",
              style: TextStyle(
                color: isLate ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}
