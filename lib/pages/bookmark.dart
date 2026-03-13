import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF4F6CD9),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Bookmark',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: const Center(
        child: Text('Tidak ada bookmark', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
