import 'package:flutter/material.dart';

class PopulerPage extends StatelessWidget {
  const PopulerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: Stack(
        children: [
          // ================= HEADER BIRU (FIXED) =================
          Container(
            height: 230,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF4F6CD9),
            ),
          ),

          // ================= LENGKUNGAN WAVE (FIXED) =================
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6FB),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
            ),
          ),

          // ================= KONTEN UTAMA =================
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. APPBAR (FIXED)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Populer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 2. HIGHLIGHT #1 (FIXED - TIDAK IKUT SCROLL)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar Cover Besar
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            // Menggunakan Image.asset langsung dengan errorBuilder
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            child: Image.asset(
                              'assets/images/populer2.jpeg',
                              fit: BoxFit.cover,
                              alignment: const Alignment(0.0, -0.5),
                              // Fallback jika gambar utama error
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFE8EDFF),
                                  child: const Center(
                                    child: Icon(Icons.broken_image_rounded,
                                        size: 50, color: Color(0xFF4F6CD9)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Detail Buku Highlight
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Badge #1
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF3E0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text("👑 ", style: TextStyle(fontSize: 14)),
                                    Text(
                                      "#1 Terpopuler Minggu Ini",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Judul
                              const Text(
                                "Hujan",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1D1D1D),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Info Penulis & Rating
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded,
                                      color: Colors.amber, size: 20),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "4.9",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle)),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.edit_document,
                                      color: Colors.grey, size: 16),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "Tere Liye",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Tombol Aksi Utama
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4F6CD9),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Pinjam Sekarang",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 3. JUDUL SECTION (FIXED)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Terpopuler Lainnya",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1D1D),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 4. LIST BUKU LAINNYA (SCROLLABLE DENGAN FADE)
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
                          Colors.transparent
                        ],
                        stops: [0.0, 0.05, 0.5, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstOut,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                      child: Column(
                        // Saya sengaja menggunakan path gambar yang salah ('ngawur')
                        // untuk mendemonstrasikan bahwa fallback icon-nya bekerja.
                        children: [
                          _buildOtherPopularItem(
                            rank: "2",
                            title: "Filosofi Teras",
                            author: "Henry Manampiring",
                            rating: "4.8",
                            imagePath: "assets/images/gambar_ngawur_1.png",
                          ),
                          _buildOtherPopularItem(
                            rank: "3",
                            title: "Bumi Manusia",
                            author: "Pramoedya Ananta Toer",
                            rating: "4.8",
                            imagePath: "assets/images/gambar_ngawur_2.png",
                          ),
                          _buildOtherPopularItem(
                            rank: "4",
                            title: "Laskar Pelangi",
                            author: "Andrea Hirata",
                            rating: "4.7",
                            imagePath:
                                "assets/images/ngawur.png", // Ini akan muncul jika filenya ada
                          ),
                          _buildOtherPopularItem(
                            rank: "5",
                            title: "Sapiens",
                            author: "Yuval Noah Harari",
                            rating: "4.7",
                            imagePath: "assets/images/gambar_ngawur_3.png",
                          ),
                          _buildOtherPopularItem(
                            rank: "6",
                            title: "Atomic Habits",
                            author: "James Clear",
                            rating: "4.9",
                            imagePath: "assets/images/gambar_ngawur_4.png",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= WIDGET PEMBANTU (YANG DIMODIFIKASI) =================
  Widget _buildOtherPopularItem({
    required String rank,
    required String title,
    required String author,
    required String rating,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Angka Ranking
          SizedBox(
            width: 30,
            child: Text(
              "#$rank",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F6CD9),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(width: 8),

          // [MODIFIKASI DI SINI] Gambar Thumbnail Buku dengan Fallback
          Container(
            height: 60,
            width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EDFF), // Warna background default
              borderRadius: BorderRadius.circular(8),
            ),
            // Gunakan ClipRRect agar gambar/icon di dalamnya mengikuti radius sudut
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                // errorBuilder ini yang menangani jika gambar tidak ditemukan
                errorBuilder: (context, error, stackTrace) {
                  // Tampilkan icon buku di tengah sebagai pengganti
                  return const Center(
                    child: Icon(
                      Icons.menu_book_rounded, // Icon buku
                      color: Color(0xFF4F6CD9),
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Info Teks (Judul, Penulis, Rating)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1D1D),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Icon Panah Kanan
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFF4F6FB),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF4F6CD9),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
