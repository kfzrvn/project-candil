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

          // BANNER
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                color: dark4,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFBDBCBC)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Icon(Icons.person, size: 60, color: blue3),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, Selamat Pagi',
                        style:
                            regular14.copyWith(color: blue3.withOpacity(0.8)),
                      ),
                      Text(
                        'Nama Pengguna',
                        style: semibold14.copyWith(color: blue3),
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

          // EXPERIENCE SECTION ⭐
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: Container(
              height: 65,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 205, 201, 252),
                    Color(0xFFFFFFFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFE8E8E8)),
              ),
              child: Stack(
                children: [
                  // DOTS BACKGROUND
                  Positioned(
                    left: 3,
                    bottom: 3,
                    child: Image.asset(
                      'assets/icons/dots.png',
                      fit: BoxFit.none,
                      alignment: Alignment.bottomLeft,
                      color: Colors.white.withOpacity(0.07),
                      colorBlendMode: BlendMode.srcATop,
                    ),
                  ),

                  // ⭐ STAR ICON
                  // ⭐ STAR ICON (UKURAN MANUAL)
                  Positioned(
                    left: 17,
                    top: 13, // cukup satu anchor
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(
                        'assets/icons/star.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
