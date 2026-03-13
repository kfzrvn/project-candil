import 'package:flutter/material.dart';
import 'chat.dart';

class ChatLandingPage extends StatefulWidget {
  const ChatLandingPage({Key? key}) : super(key: key);

  @override
  State<ChatLandingPage> createState() => _ChatLandingPageState();
}

class _ChatLandingPageState extends State<ChatLandingPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> item1Opacity;
  late Animation<Offset> item1Slide;

  late Animation<double> item2Opacity;
  late Animation<Offset> item2Slide;

  late Animation<double> item3Opacity;
  late Animation<Offset> item3Slide;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    item1Opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    item1Slide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    item2Opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.6)),
    );

    item2Slide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.6)),
    );

    item3Opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)),
    );

    item3Slide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)),
    );

    _controller.forward();
  }

  Widget buildAnimatedItem(
      Animation<double> opacity, Animation<Offset> slide, String text) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.check_circle,
                  color: Color(0xFF4A7BFF), size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Selamat Datang!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9C7BFF),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Chat dengan chatbot Candil untuk menanyakan\ninformasi mengenai perpustakaan!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/chatbot.png', // pastikan ada
                height: 220,
              ),
              const SizedBox(height: 30),
              buildAnimatedItem(
                  item1Opacity, item1Slide, "Menanyakan Buku yang tersedia"),
              buildAnimatedItem(
                  item2Opacity, item2Slide, "Informasi Peminjaman Buku"),
              buildAnimatedItem(
                  item3Opacity, item3Slide, "Bantuan akun perpustakaan"),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                    );
                  },
                  child: const Text(
                    "Mulai Chat",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
