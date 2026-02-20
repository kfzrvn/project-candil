import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agree = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  Future<void> _register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showDialog('Semua field wajib diisi');
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
      // CREATE USER
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 🔥 SIMPAN NAMA KE FIREBASE
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      _showDialog(
        'Registrasi berhasil, silakan login',
        success: true,
      );
    } on FirebaseAuthException catch (e) {
      _showDialog(e.message ?? 'Registrasi gagal');
    }
  }

  // ================= DIALOG =================
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

  // ================= INPUT =================
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
              const SizedBox(height: 20),
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
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (v) => setState(() => agree = v ?? false),
                  ),
                  const Expanded(
                    child: Text('Saya setuju dengan syarat & ketentuan'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text('Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
