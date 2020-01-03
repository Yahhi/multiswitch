import 'dart:math';

import 'package:flutter/material.dart';

class SwitchRoutePainter extends CustomPainter {
  static const _SIZE = 20.0;

  final double radius;
  final Offset center;

  SwitchRoutePainter(this.radius, this.center);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = new SweepGradient(
      startAngle: 3 * pi / 2,
      endAngle: 7 * pi / 2,
      tileMode: TileMode.repeated,
      colors: [Colors.blue, Colors.green],
    );

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = _SIZE;
    final center = new Offset(size.width / 2, size.height / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi;
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(SwitchRoutePainter oldDelegate) {
    return true;
  }
}
