import 'package:flutter/material.dart';
import 'package:candil/components/header.dart';
import 'package:candil/pages/beranda.dart';
import 'package:candil/pages/baca.dart';
import 'package:candil/pages/pinjam.dart';
import 'package:candil/pages/chat.dart';
import 'package:candil/theme.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blue3,
        elevation: 0,
        toolbarHeight: 90,
        title: Header(
          currentIndex: currentIndex,
          onChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          const BerandaPage(),
          const BacaPage(),
          PinjamPage(),
          const ChatPage(),
        ],
      ),
    );
  }
}
