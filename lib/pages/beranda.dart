import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:candil/datas/icons.dart';
import 'package:candil/theme.dart';
import 'package:candil/pages/kategori.dart';
import 'package:candil/pages/login_page.dart';

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
        // ================= SEARCH BAR =================
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

        // BANNER PROFILE + LOGOUT
        Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 157, 181, 245),
                      const Color.fromARGB(255, 203, 213, 240),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
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
                          'Halo, Selamat Datang 👋',
                          style: regular14.copyWith(
                            color: blue1.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          userName,
                          style: semibold14.copyWith(color: blue1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 🔥 LOGOUT BUTTON
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  color: blue1,
                  onPressed: _logout,
                  tooltip: 'Logout',
                ),
              ),
            ],
          ),
        ),

        // ================= MENU ICONS =================
        Padding(
          padding: const EdgeInsets.only(left: 27, right: 27, top: 32),
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

        // Page trnedning
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
          child: Text(
            "Trending",
            style: bold18.copyWith(color: dark1),
          ),
        ),

        // =Conten
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8E8E8)),
              ),
              alignment: Alignment.center,
              child: Text(
                'Konten Trending',
                style: regular14.copyWith(color: dark2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
