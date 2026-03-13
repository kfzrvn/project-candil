import 'package:flutter/material.dart';
import 'package:candil/theme.dart';

class Header extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChanged;

  const Header({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                left: currentIndex * tabWidth,
                top: 0,
                bottom: 0,
                width: tabWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              Row(
                children: List.generate(tabs.length, (index) {
                  final isActive = index == currentIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(index),
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            tabs[index],
                            style: semibold14.copyWith(
                              color: isActive ? blue1 : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
