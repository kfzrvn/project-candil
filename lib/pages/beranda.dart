import 'package:flutter/material.dart';
import 'package:candil/datas/icons.dart';
import 'package:candil/theme.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =========================================
        // BAGIAN FIXED (HEADER + JUDUL TRENDING)
        // =========================================

        // 1. SEARCH BAR
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

        // 2. BANNER PROFILE
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 157, 181, 245),
                  Color.fromARGB(255, 203, 213, 240),
                ],
                stops: const [0.0, 0.8],
              ),
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
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
                Icon(Icons.person, size: 60, color: blue1),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, Selamat Pagi',
                      style: regular14.copyWith(color: blue1.withOpacity(0.9)),
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

        // 4. JUDUL TRENDING (PINDAH KE SINI AGAR FIXED/DIAM)
        Padding(
          // Atur jarak atas dari menu icon (30) dan bawah ke kartu (10)
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Text(
            "Trending",
            style: bold18.copyWith(color: dark1),
          ),
        ),

        // =========================================
        // BAGIAN SCROLLABLE (HANYA KARTU)
        // =========================================

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
                15, 0, 15, 30), // Top 0 karena judul sudah di luar
            child: Column(
              children: [
                // KARTU UTAMA
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BAGIAN A: GAMBAR
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/images/news1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // BAGIAN B: TEKS KETERANGAN
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Makin Seru 😉",
                              style: semibold14.copyWith(
                                  fontSize: 16,
                                  color: dark1,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Temukan koleksi buku terbaru dan promo menarik minggu ini. Jangan sampai kelewatan!",
                              style: regular14.copyWith(
                                color: const Color(0xFF757575),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}