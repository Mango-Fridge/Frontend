import 'package:flutter/material.dart';

Widget dottedDivider({
  Color color = Colors.black,
  double dashWidth = 1.0,
  double dashSpace = 3.0,
  String text = "",
}) {
  return CustomPaint(
    painter: _DottedLineWithTextPainter(color, dashWidth, dashSpace, text),
    child: Container(),
  );
}

// CustomPainter로 점선 텍스트 점선 그리기
class _DottedLineWithTextPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final String text;

  _DottedLineWithTextPainter(
    this.color,
    this.dashWidth,
    this.dashSpace,
    this.text,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    double startX = 0;
    // 왼쪽 점선 그리기
    while (startX < size.width / 2 - 40) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }

    // 텍스트 그리기
    if (text.isNotEmpty) {
      final TextStyle textStyle = TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Mainfonts',
      );
      final TextSpan textSpan = TextSpan(text: text, style: textStyle);
      final TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      double textX = (size.width - textPainter.width) / 2;
      double textY = -10;

      textPainter.paint(canvas, Offset(textX, textY));
    }

    startX = size.width / 2 + 40;

    // 오른쪽 점선 그리기
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
