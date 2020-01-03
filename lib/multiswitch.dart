library multiswitch;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiswitch/math_helper.dart';
import 'package:multiswitch/switch_route_painter.dart';

/// A Calculator.
class Multiswitch extends StatefulWidget {
  final List<String> options;
  final double distanceToCircle;
  final double circleRadius;
  final ValueChanged<String> onChanged;

  const Multiswitch(
      {Key key,
      @required this.options,
      this.distanceToCircle = 4.0,
      this.circleRadius = 100.0,
      this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MultiswitchState();
  }
}

class _MultiswitchState extends State<Multiswitch>
    with SingleTickerProviderStateMixin {
  static const _DISTANCE_TO_CIRCLE = 8.0;
  static const _EDGE_DISTANCE_X = 60.0;
  static const _EDGE_DISTANCE_Y = 30.0;

  String _selectedValue;
  List<Widget> rotatedWidgets = new List();
  List<double> rotationAngles = new List();
  double selectedRotation = 0;
  double rotationStep;
  Offset circleCenter;

  AnimationController controller;
  Animation rotationAnimation, rotation2;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    rotationAnimation =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    rotation2 = CurvedAnimation(parent: controller, curve: Curves.linear);

    WidgetsBinding.instance.addPostFrameCallback(_doLayout);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: rotatedWidgets,
    );
  }

  void _doLayout(Duration timeStamp) {
    circleCenter = Offset(MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2);
    print("circle center is $circleCenter");

    rotationStep = 2 * pi / widget.options.length;
    print("rotation step $rotationStep");
    double rotationRadian = 0;
    for (String option in widget.options) {
      rotationAngles.add(rotationRadian);
      double angle;
      if (rotationRadian < pi / 2) {
        angle = rotationRadian;
      } else if (rotationRadian < pi) {
        angle = pi - rotationRadian;
      } else if (rotationRadian < 1.5 * pi) {
        angle = rotationRadian - pi;
      } else {
        angle = 2 * pi - rotationRadian;
      }
      print("actual angle to count $angle");
      double adjacentLeg = cos(angle) * widget.circleRadius;
      double oppositeLeg = sin(angle) * widget.circleRadius;
      double x, y;
      if (rotationRadian < pi) {
        x = circleCenter.dx + oppositeLeg + _DISTANCE_TO_CIRCLE;
      } else {
        x = circleCenter.dx -
            oppositeLeg -
            _EDGE_DISTANCE_X -
            _DISTANCE_TO_CIRCLE;
      }
      if (rotationRadian < pi / 2 || rotationRadian > pi * 1.5) {
        y = circleCenter.dy -
            adjacentLeg -
            _DISTANCE_TO_CIRCLE -
            _EDGE_DISTANCE_Y;
      } else {
        y = circleCenter.dy + adjacentLeg + _DISTANCE_TO_CIRCLE;
      }
      print("x $x, y $y");

      rotatedWidgets.add(Positioned(
        top: y,
        left: x,
        child: FlatButton(
          child: Text(option),
          onPressed: () {
            _movePointerTo(option);
          },
        ),
      ));
      rotationRadian += rotationStep;
      print("rotation radian $rotationRadian");
    }
    rotationAngles.add(rotationRadian);

    rotatedWidgets.add(
      Positioned(
        top: circleCenter.dy,
        left: circleCenter.dx,
        child: RotationTransition(
            turns: rotationAnimation,
            child: CustomPaint(
              painter: SwitchRoutePainter(
                widget.circleRadius,
                circleCenter,
              ),
            )),
      ),
    );
    rotatedWidgets.add(
      Positioned(
        top: circleCenter.dy - widget.circleRadius - 10.0,
        left: circleCenter.dx - widget.circleRadius - 10.0,
        child: RotationTransition(
          turns: rotation2,
          child: Container(
            alignment: Alignment.topCenter,
            height: widget.circleRadius * 2 + 20.0,
            width: widget.circleRadius * 2 + 20.0,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
    rotatedWidgets.add(Positioned.fill(
        child: GestureDetector(
      onPanUpdate: _updatePosition,
      onPanEnd: _setSelection,
      onPanCancel: _finishSelection,
    )));
    setState(() {});
  }

  void _movePointerTo(String option) {
    print("let's rotate to $option");
    final int indexOfOption = widget.options.indexOf(option);
    double rotationPercent = indexOfOption / widget.options.length;
    controller.animateTo(rotationPercent);
    if (widget.onChanged != null) {
      widget.onChanged(option);
    }
  }

  void _updatePosition(DragUpdateDetails details) {
    selectedRotation = MathHelper.transformOffsetToCirclePercent(
        details.localPosition, circleCenter, widget.circleRadius);
    controller.value = selectedRotation;
  }

  void _setSelection(DragEndDetails details) {
    print("drag finished");
    _finishSelection();
  }

  void _finishSelection() {
    print("finish selection");
    final int selectedIndex =
        MathHelper.getSelectionIndex(selectedRotation, rotationAngles);
    controller.animateTo(rotationAngles[selectedIndex] / (2 * pi));
    if (widget.onChanged != null) {
      if (selectedIndex == widget.options.length) {
        widget.onChanged(widget.options.first);
      } else {
        widget.onChanged(widget.options[selectedIndex]);
      }
    }
  }
}
