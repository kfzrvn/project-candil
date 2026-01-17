import 'package:flutter/material.dart';
import 'package:candil/theme.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int activeIndex = 0;
  final List<String> menus = ['Beranda', 'Baca', 'Pinjam', 'Chat'];

  Alignment _alignmentForIndex(int index) {
    final step = 2 / (menus.length - 1);
    return Alignment(-1 + (step * index), 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: blue1,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          /// 🔹 BOX PUTIH (GESER)
          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: _alignmentForIndex(activeIndex),
            child: FractionallySizedBox(
              widthFactor: 1 / menus.length,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),

          /// 🔹 MENU TEXT
          Row(
            children: List.generate(menus.length, (index) {
              final bool isActive = index == activeIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  child: Container(
                    height: 44,
                    alignment: Alignment.center,
                    child: Text(
                      menus[index],
                      style: semibold14.copyWith(
                        color: isActive ? blue1 : Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
