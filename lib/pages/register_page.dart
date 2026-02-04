import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ================= BARU (1) CONTROLLERS =================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agree = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  // ================= BARU (2) REGISTER FUNCTION =================
  Future<void> _register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showDialog('Form belum lengkap');
      return;
    }

    if (password != confirmPassword) {
      _showDialog('Password tidak sama');
      return;
    }

    if (!agree) {
      _showDialog('Kamu harus menyetujui syarat & ketentuan');
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showDialog(
        'Registrasi berhasil',
        success: true,
      );
    } on FirebaseAuthException catch (e) {
      _showDialog(e.message ?? 'Register gagal');
    }
  }

  // ================= BARU (3) iOS STYLE POPUP =================
  void _showDialog(String message, {bool success = false}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(success ? 'Berhasil' : 'Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (success) Navigator.pop(context); // balik ke login
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ================= 3D INPUT =================
  Widget build3DInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool showEye = false,
    VoidCallback? toggle,
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
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: showEye
              ? IconButton(
                  icon: Icon(
                    isPassword
                        ? Icons.visibility_off
                        : Icons.visibility_outlined,
                  ),
                  onPressed: toggle,
                )
              : null,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // ================= HEADER =================
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              Image.asset(
                'assets/images/logo_candil.png',
                width: 150,
              ),

              const SizedBox(height: 12),

              const Text(
                'Candil',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Buat akun baru',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),
              const Text(
                'Satu akun untuk membaca ribuan buku',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF686868),
                ),
              ),

              const SizedBox(height: 28),

              // ================= INPUT =================
              build3DInput(
                controller: nameController,
                hint: 'Nama lengkap',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              build3DInput(
                controller: emailController,
                hint: 'Email',
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 18),

              build3DInput(
                controller: passwordController,
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: !showPassword,
                showEye: true,
                toggle: () => setState(() => showPassword = !showPassword),
              ),

              const SizedBox(height: 18),

              build3DInput(
                controller: confirmPasswordController,
                hint: 'Konfirmasi Password',
                icon: Icons.lock_outline,
                isPassword: !showConfirmPassword,
                showEye: true,
                toggle: () =>
                    setState(() => showConfirmPassword = !showConfirmPassword),
              ),

              const SizedBox(height: 18),

              // ================= CHECKBOX =================
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (v) => setState(() => agree = v ?? false),
                    activeColor: const Color(0xFF6E8B6A),
                  ),
                  const Expanded(
                    child: Text(
                      'Saya setuju dengan syarat & ketentuan',
                      style: TextStyle(
                        color: Color(0xFF6E8B6A),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _register, // ⭐ BARU
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E8B6A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ================= FOOTER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Sudah punya akun? '),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF3F63D3),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
