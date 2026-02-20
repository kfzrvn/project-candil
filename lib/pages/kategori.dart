import 'package:flutter/material.dart';
import 'package:candil/theme.dart'; // Pastikan import theme benar

class KategoriPage extends StatelessWidget {
  const KategoriPage({Key? key}) : super(key: key);

  // Data Dummy Kategori
  final List<Map<String, dynamic>> categories = const [
    {"title": "Fiksi", "color": 0xFFE3F2FD, "icon": Icons.auto_stories},
    {"title": "Sains", "color": 0xFFFCE4EC, "icon": Icons.science},
    {"title": "Sejarah", "color": 0xFFE8F5E9, "icon": Icons.history_edu},
    {"title": "Teknologi", "color": 0xFFFFF3E0, "icon": Icons.computer},
    {"title": "Bisnis", "color": 0xFFF3E5F5, "icon": Icons.business_center},
    {"title": "Seni", "color": 0xFFE0F7FA, "icon": Icons.palette},
    {"title": "Biografi", "color": 0xFFFFF8E1, "icon": Icons.person},
    {"title": "Komik", "color": 0xFFFFEBEE, "icon": Icons.emoji_emotions},
    {"title": "Kuliner", "color": 0xFFFFCCBC, "icon": Icons.restaurant_menu},
    {"title": "Kesehatan", "color": 0xFFC8E6C9, "icon": Icons.favorite},
    {"title": "Travel", "color": 0xFFB2EBF2, "icon": Icons.flight_takeoff},
    {"title": "Hukum", "color": 0xFFD7CCC8, "icon": Icons.gavel},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          // [MODIFIKASI] Ubah warna icon back menjadi blue1
          icon: Icon(Icons.arrow_back_ios_new, color: blue1),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Kategori Buku",
          // [MODIFIKASI] Ubah warna judul menjadi blue1
          style: bold18.copyWith(color: blue1),
        ),
      ),
      body: ShaderMask(
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
            // Efek pudar tipis (2%)
            stops: [0.0, 0.02, 0.95, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final cat = categories[index];
            return Container(
              decoration: BoxDecoration(
                color: Color(cat['color']),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat['icon'], color: Colors.black54, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    cat['title'],
                    style: semibold14.copyWith(color: Colors.black87),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
