import 'package:flutter/material.dart';
import 'package:candil/theme.dart';

class Header extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChanged;

  const Header({
    Key? key,
    required this.currentIndex,
    required this.onChanged,
  }) : super(key: key);

  final tabs = const ['Beranda', 'Baca', 'Pinjam', 'Chat'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: blue1,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          // ANIMATED BACKGROUND
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            alignment: Alignment(
              -1 + (currentIndex * 2 / (tabs.length - 1)),
              0,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 4 - 20,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),

          // TABS
          Row(
            children: List.generate(tabs.length, (index) {
              final isActive = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  child: Center(
                    child: Text(
                      tabs[index],
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
