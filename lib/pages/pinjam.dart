import 'package:flutter/material.dart';

import 'package:candil/theme.dart'; // Pastikan import theme benar

class PinjamPage extends StatelessWidget {
  PinjamPage({Key? key}) : super(key: key);

  // DATA DUMMY BUKU

  final List<Map<String, String>> bookList = [
    {
      "title": "Harry Potter: The Book",
      "author": "Stern Manson",
      "rating": "6.0"
    },
    {
      "title": "Harry Potter: The Portal",
      "author": "Jim Fiah",
      "rating": "4.0"
    },
    {
      "title": "Sherlock Holmes",
      "author": "Arthur Conan Doyle",
      "rating": "5.0"
    },
    {"title": "Atomic Habits", "author": "James Clear", "rating": "4.8"},
    {
      "title": "The Psychology of Money",
      "author": "Morgan Housel",
      "rating": "4.9"
    },
    {
      "title": "Rich Dad Poor Dad",
      "author": "Robert Kiyosaki",
      "rating": "4.7"
    },
    {"title": "The Alchemist", "author": "Paulo Coelho", "rating": "4.5"},
    {"title": "Sapiens", "author": "Yuval Noah Harari", "rating": "4.6"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // 1. DASHBOARD MONITORING (Gradasi Dibalik)

          _buildMonitoringDashboard(),

          // 2. SEARCH BAR

          _buildSearchBar(),

          // 3. Judul Section

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Daftar Buku Rekomendasi",
              style: bold18.copyWith(color: Colors.black87),
            ),
          ),

          // 4. LIST BUKU SCROLLABLE

          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.purple
                  ],
                  stops: [0.0, 0.05, 1.0, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                itemCount: bookList.length,
                itemBuilder: (context, index) {
                  final book = bookList[index];

                  return _buildBookItem(
                    title: book['title']!,
                    author: book['author']!,
                    rating: book['rating']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET 1: MONITORING DASHBOARD (ARAH GRADASI DIBALIK)

  Widget _buildMonitoringDashboard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // [MODIFIKASI] Arah gradasi dibalik (Bottom -> Top)

        gradient: const LinearGradient(
            begin: Alignment.bottomCenter, // Mulai dari bawah (Terang)

            end: Alignment.topCenter, // Ke atas (Gelap)

            colors: [
              // Cream original (Bawah)

              Color.fromARGB(255, 203, 213, 240),

              Color.fromARGB(255, 157, 181, 245), // Cream gelap/oranye (Atas)
            ],
            stops: const [
              0.1,
              0.6
            ]),

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3 Buku",
                    style: bold18.copyWith(fontSize: 28, color: blue1),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Sedang dipinjam",
                    style: regular14.copyWith(color: blue1),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  // Border mengikuti warna icon (Blue3)
                  border: Border.all(color: blue3.withOpacity(0.3), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: blue3.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                // Icon menggunakan Blue3
                child: Icon(Icons.auto_stories, color: blue3, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // MASIH BINGUNG MAU DIISI APA

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // WIDGET 2: SEARCH BAR

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
      child: TextField(
        style: regular14.copyWith(color: Colors.black87),
        decoration: InputDecoration(
          hintText: "Cari buku yang ingin dipinjam...",
          hintStyle: regular14.copyWith(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  // WIDGET 3: ITEM BUKU

  Widget _buildBookItem(
      {required String title, required String author, required String rating}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage("https://via.placeholder.com/150"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: const Icon(Icons.book, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: bold16.copyWith(color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "by $author",
                  style: regular12_5.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: semibold12_5.copyWith(color: Colors.black87),
                    ),
                  ],
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD54F),
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              "Pinjam",
              style: semibold12_5.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
