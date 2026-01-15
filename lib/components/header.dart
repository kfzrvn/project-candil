import 'package:flutter/material.dart';
import 'package:candil/theme.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(color: blue1, borderRadius: BorderRadius.circular(30)),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.2, vertical: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
          child: Text(
            'Beranda',
            style: semibold14.copyWith(color: blue1),
          ),
        ),
        ...['Baca', 'Pinjam', 'Chat'].map((title) => Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26.2, vertical: 12),
                child: Center(
                  child: Text(
                    title,
                    style: semibold14.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}
