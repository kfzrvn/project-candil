import 'package:flutter/material.dart';
import 'package:candil/theme.dart';

class BacaPage extends StatefulWidget {
  const BacaPage({Key? key}) : super(key: key);

  @override
  State<BacaPage> createState() => _BacaPageState();
}

class _BacaPageState extends State<BacaPage> {
  int selectedCategory = 0;

  final List<String> categories = [
    'Semua',
    'Novel',
    'Komik',
    'Pendidikan',
    'Sejarah',
    'Teknologi',
  ];

  final List<Color> pastelColors = [
    Color(0xFFE3F2FD),
    Color(0xFFFCE4EC),
    Color(0xFFE8F5E9),
    Color(0xFFF3E5F5),
    Color(0xFFFFF3E0),
    Color(0xFFE0F7FA),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),

        /// =========================
        /// KATEGORI
        /// =========================
        SizedBox(
          height: 62,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final bool isActive = selectedCategory == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFFFD54F)
                        : pastelColors[index % pastelColors.length],
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          isActive ? 0.18 : 0.08,
                        ),
                        blurRadius: isActive ? 3 : 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: semibold14.copyWith(
                        color: isActive ? Colors.white : dark2,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        /// =========================
        /// LIST BUKU DENGAN SHADER MASK
        /// =========================
        Expanded(
          // [MODIFIKASI] Menambahkan ShaderMask
          child: ShaderMask(
            shaderCallback: (Rect rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple, // Warna atas (akan jadi transparan)
                  Colors.transparent, // Warna tengah (akan terlihat jelas)
                  Colors.transparent,
                  Colors.purple // Warna bawah (jika ingin fade bawah juga)
                ],
                stops: [
                  0.0, // Mulai pudar di paling atas
                  0.05, // Mulai jelas di 5% dari atas
                  0.95, // Mulai pudar lagi di 95% ke bawah (opsional)
                  1.0
                ],
              ).createShader(rect);
            },
            blendMode: BlendMode
                .dstOut, // Mode agar warna ungu membuat konten jadi transparan
            child: ListView.builder(
              // Tambahkan padding top agar item pertama tidak terlalu mepet pudar
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                        width: 45,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFECB3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.book,
                          size: 28,
                          color: Color(0xFFFFA000),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Judul Buku ${index + 1}',
                              style: semibold14.copyWith(color: dark1),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Nama Penulis',
                              style: regular12_5.copyWith(color: dark3),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
