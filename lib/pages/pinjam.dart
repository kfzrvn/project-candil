import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:candil/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:candil/pages/borrowed_books_page.dart';

class PinjamPage extends StatelessWidget {
  PinjamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildMonitoringDashboard(context),
          _buildSearchBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Daftar Buku Rekomendasi",
              style: bold18.copyWith(color: Colors.black87),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('books').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Belum ada buku di database"),
                  );
                }

                final books = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];

                    return _buildBookItem(
                      bookId: book.id,
                      title: book['JudulBuku'],
                      author: book['Penulis'],
                      year: book['Tahun'].toString(),
                      stock: book['Stok'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // DASHBOARD
  Widget _buildMonitoringDashboard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BorrowedBooksPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 203, 213, 240),
              Color.fromARGB(255, 157, 181, 245),
            ],
            stops: [0.1, 0.6],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: blue3.withOpacity(0.4),
              blurRadius: 25,
              offset: Offset.zero,
              spreadRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('peminjaman')
                      .where(
                        'userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .where('status', isEqualTo: 'dipinjam')
                      .snapshots(),
                  builder: (context, snapshot) {
                    int total = snapshot.data?.docs.length ?? 0;

                    return Text(
                      "$total Buku",
                      style: bold18.copyWith(
                        fontSize: 28,
                        color: blue1,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  "Sedang dipinjam",
                  style: regular14.copyWith(
                    color: blue1,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: blue3.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: blue3.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.auto_stories,
                color: blue3,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SEARCH BAR
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Cari buku yang ingin dipinjam...",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Gambar buku yang di pinjam masih manual //
  String getImageFromTitle(String title) {
    switch (title.toLowerCase()) {
      case "ayah":
        return "assets/images/buku/ayah.png";
      case "ikigai":
        return "assets/images/buku/ikigai.jpg";
      case "harry potter dan piala api":
        return "assets/images/buku/harrypotah.jpg";
      case "kasatria":
        return "assets/images/buku/ksatria.jpg";
      case "padang":
        return "assets/images/buku/padang.jpg";
      default:
        return "assets/images/buku/default.png";
    }
  }

  // item buku //
  Widget _buildBookItem({
    required String bookId,
    required String title,
    required String author,
    required String year,
    required int stock,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(getImageFromTitle(title)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: bold16),
                const SizedBox(height: 4),
                Text("by $author", style: regular12_5),
                Text("Tahun: $year"),
                const SizedBox(height: 4),
                Text(
                  "Stok: $stock",
                  style: TextStyle(
                    color: stock > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: stock > 0
                ? () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user == null) return;
                    final bookRef = FirebaseFirestore.instance
                        .collection('books')
                        .doc(bookId);

                    final bookSnapshot = await bookRef.get();
                    int currentStock = bookSnapshot['Stok'];

                    if (currentStock <= 0) return;

                    await FirebaseFirestore.instance
                        .collection('peminjaman')
                        .add({
                      'userId': user.uid,
                      'bookId': bookId,
                      'status': 'dipinjam',
                      'tanggalPinjam': Timestamp.now(),
                    });

                    await bookRef.update({
                      'Stok': currentStock - 1,
                    });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD54F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Pinjam"),
          ),
        ],
      ),
    );
  }
}
