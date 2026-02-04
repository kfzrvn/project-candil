import 'package:flutter/material.dart';
import 'package:candil/theme.dart';

class BacaPage extends StatefulWidget {
  const BacaPage({super.key});

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
        // [TAMBAHAN] SEARCH BAR
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFE8E8E8)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 24, color: blue3),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Telusuri Buku',
                    style: regular14.copyWith(color: dark3),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // KATEGORI
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

        // =========================================
        // LIST BUKU
        // =========================================
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
                stops: [0.0, 0.05, 0.95, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ListView.builder(
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
