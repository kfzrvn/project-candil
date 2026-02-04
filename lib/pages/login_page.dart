import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ================= iOS STYLE POPUP =================
  void _showIosAlert(String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(message),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // ================= LOGIN FIREBASE =================
  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showIosAlert('Login Gagal', 'Email dan password wajib diisi');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // LOGIN BERHASIL
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Homepage()),
      );
    } on FirebaseAuthException catch (e) {
      _showIosAlert(
        'Login Gagal',
        e.message ?? 'Email atau password salah',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: const Color(0xFF3F63D3),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_candil.png',
                          width: 140,
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Candil',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 202,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/shape_bodas.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -20),
              child: Column(
                children: const [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Masuk untuk Akses Aplikasi',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // EMAIL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _inputBox(
                controller: emailController,
                hint: 'Email',
                icon: Icons.email_outlined,
                obscure: false,
              ),
            ),

            const SizedBox(height: 18),

            // PASSWORD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _inputBox(
                controller: passwordController,
                hint: 'Password',
                icon: Icons.lock_outline,
                obscure: true,
              ),
            ),

            const SizedBox(height: 28),

            // LOGIN BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F63D3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 80, child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('atau'),
                ),
                SizedBox(width: 80, child: Divider()),
              ],
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/google.png',
                width: 20,
              ),
              label: const Text('Login dengan Google'),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum punya akun? '),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFF3F63D3),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// INput Box
Widget _inputBox({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  required bool obscure,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
      ),
    ),
  );
}
