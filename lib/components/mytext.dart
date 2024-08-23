import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String data;
  final double fontSize;
  const MyText({super.key, required this.data, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: 'Friends',
        fontSize: fontSize,
        color: Colors.white,
        shadows: [
          Shadow(
            offset: const Offset(2.0, 2.0),
            blurRadius: 3.0,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
