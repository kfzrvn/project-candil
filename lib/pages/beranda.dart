import 'package:flutter/material.dart';
import 'package:candil/datas/icons.dart';
import 'package:candil/theme.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.only(top: 23, left: 15, right: 15),
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
                  Text(
                    'Telusuri Buku',
                    style: regular14.copyWith(color: dark3),
                  ),
                ],
              ),
            ),
          ),

          // BANNER (MODIFIKASI: GRADASI & WARNA PUTIH)
          // BANNER (GRADASI LEBIH INTENS)
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                // [MODIFIKASI] Gradasi lebih kontras (Intens)
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // Opacity 0.5 membuat warna awal jauh lebih muda/terang
                    // sehingga kontras dengan warna akhir (efek kilat lebih kuat)
                    Color.fromARGB(255, 157, 181, 245),
                    Color.fromARGB(255, 203, 213, 240),
                  ],
                  // Mengatur titik perpindahan agar cahaya fokus di pojok kiri atas
                  stops: const [0.0, 0.8],
                ),
                borderRadius: BorderRadius.circular(15),
                // Border putih tipis transparan untuk mempercantik
                border: Border.all(
                    color: Colors.white.withOpacity(0.2), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: blue3.withOpacity(0.4),
                    blurRadius: 17,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  // Icon User Putih
                  Icon(Icons.person, size: 60, color: blue1),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Teks Putih
                      Text(
                        'Halo, Selamat Pagi',
                        style:
                            regular14.copyWith(color: blue1.withOpacity(0.9)),
                      ),
                      Text(
                        'Nama Pengguna',
                        style: semibold14.copyWith(color: blue1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // MENU ICONS
          Padding(
            padding: const EdgeInsets.only(left: 27, right: 27, top: 32),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              children: menuIcons.map((icon) {
                return Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFE8E8E8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          icon.iconData,
                          size: 24,
                          color: icon.color ?? blue3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      icon.title,
                      style: regular12_5.copyWith(color: dark2),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
