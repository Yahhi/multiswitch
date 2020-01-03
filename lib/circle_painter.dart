import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  var wavePaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    canvas.drawCircle(Offset(centerX, centerY), 100.0, wavePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return true;
  }
}
