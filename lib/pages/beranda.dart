import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:candil/datas/icons.dart';
import 'package:candil/theme.dart';
import 'package:candil/pages/kategori.dart';
import 'package:candil/pages/login_page.dart';
import 'package:candil/pages/profile_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  String userName = 'Pengguna';

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userName =
            user.displayName ?? user.email?.split('@').first ?? 'Pengguna';
      });
    }
  }

  // ================= LOGOUT =================
  void _logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Keluar Akun'),
        content: const Text('Yakin ingin logout dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  // ================= HANDLE MENU =================
  void _handleMenuTap(BuildContext context, String title) {
    switch (title) {
      case 'Kategori':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const KategoriPage()),
        );
        break;

      case 'Edit Profil':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Fitur $title belum tersedia"),
            duration: const Duration(seconds: 1),
            backgroundColor: dark1,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================= SEARCH =================
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

// ================= BANNER PROFILE =================
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 125,
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  color: blue3.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18), // 🔥 INI YANG BIKIN POSISI NAIK
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AVATAR
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.person, size: 40, color: blue1),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // TEKS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Selamat Datang',
                          style: bold18.copyWith(
                            color: blue1.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userName,
                          style: regular14.copyWith(
                            // 🔥 tidak bold
                            color: blue1,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // LOGOUT ICON
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: _logout,
                      child: Icon(
                        Icons.logout_rounded,
                        size: 22,
                        color: blue1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // MENU ICON
        Padding(
          padding: const EdgeInsets.only(left: 27, right: 27, top: 28),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            children: menuIcons.map((icon) {
              return GestureDetector(
                onTap: () => _handleMenuTap(context, icon.title),
                child: Column(
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
                ),
              );
            }).toList(),
          ),
        ),

        // ================= HEADER TRENDING =================
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.only(left: 25, right: 90),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Koleksi Terbaru & Populer",
                  style: bold16.copyWith(
                    color: const Color(0xFF0D47A1),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: -25,
                child: Image.asset(
                  'assets/images/book.png',
                  height: 110,
                ),
              ),
            ],
          ),
        ),

        // ================= TRENDING CARD =================
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8E8E8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Makin Seru 😉",
                          style: semibold14.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w700),
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
          ),
        ),
      ],
    );
  }
}
