import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF4F6CD9),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Bantuan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _bikinFaq('Cara pinjem buku gmn bang?',
              'Tinggal pencet pinjam skrg di detail buku lu kira gmn lg 💀'),
          _bikinFaq('Kok buku gw ilang?',
              'Cek riwayat pinjam ato denda lu jgn2 kelewat batas 🤓'),
          _bikinFaq('Cara ganti pw gmn?', 'Ke menu edit profil king 🫩'),
        ],
      ),
    );
  }

  Widget _bikinFaq(String tanya, String jawab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(tanya, style: const TextStyle(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(jawab, style: const TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}
