import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  Widget build3DInput({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool showEye = false,
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
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: showEye ? const Icon(Icons.visibility_outlined) : null,
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

              const SizedBox(height: 10),

              // Logo
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
                  color: Color.fromARGB(255, 104, 104, 104),
                ),
              ),

              const SizedBox(height: 28),

              // ================= INPUT =================
              build3DInput(
                hint: 'Nama lengkap',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              build3DInput(
                hint: 'Email',
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 18),

              build3DInput(
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                showEye: true,
              ),

              const SizedBox(height: 18),

              build3DInput(
                hint: 'Konfirmasi Password',
                icon: Icons.lock_outline,
                isPassword: true,
                showEye: true,
              ),

              const SizedBox(height: 18),
              // Check box
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (v) {},
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
                  onPressed: () {},
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