import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mango/design.dart';

class AsteriskLabel extends StatelessWidget {
  final String text;
  final Color color;

  const AsteriskLabel({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AsteriskPainter(color: color),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: Design.normalFontSize1,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AsteriskPainter extends CustomPainter {
  final Color color;

  const AsteriskPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const String text = '*';
    final TextStyle textStyle = TextStyle(
      fontFamily: 'Mainfonts',
      color: color,
      fontSize: Design.normalFontSize1,
      fontWeight: FontWeight.bold,
    );

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final Offset offset = Offset(
      size.width - textPainter.width / 10,
      -textPainter.height / 15,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
