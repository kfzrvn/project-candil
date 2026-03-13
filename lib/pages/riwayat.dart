import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF4F6CD9),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Riwayat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'Belum ada riwayat peminjaman',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
