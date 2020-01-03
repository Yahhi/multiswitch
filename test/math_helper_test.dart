import 'package:flutter_test/flutter_test.dart';
import 'package:multiswitch/math_helper.dart';

void main() {
  group("calculate angle", () {
    final circleCenter = Offset(180.0, 301.0);
    final radius = 100.0;

    test("angle percent is zero when Offset is upper then circle center", () {
      final testValue = Offset(180.0, 250.0);
      expect(
          MathHelper.transformOffsetToCirclePercent(
              testValue, circleCenter, radius),
          moreOrLessEquals(0.0, epsilon: 0.01));
    });

    test("angle percent is 0.25 when Offset is on right of circle center", () {
      final testValue = Offset(250.0, 301.0);
      expect(
          MathHelper.transformOffsetToCirclePercent(
              testValue, circleCenter, radius),
          moreOrLessEquals(0.25, epsilon: 0.01));
    });

    test("angle percent is 0.75 when offset is on left of circle center", () {
      final testValue = Offset(100.0, 301.0);
      expect(
          MathHelper.transformOffsetToCirclePercent(
              testValue, circleCenter, radius),
          moreOrLessEquals(0.75, epsilon: 0.01));
    });

    test("angle percent is 0.5 when offset is below circle center", () {
      final testValue = Offset(180.0, 400.0);
      expect(
          MathHelper.transformOffsetToCirclePercent(
              testValue, circleCenter, radius),
          moreOrLessEquals(0.5, epsilon: 0.01));
    });
  });

  group("select final value", () {
    final dotsPlaces = [0.0, 1.56, 3.14, 6.28];

    test("when the same value is selected return it", () {
      expect(MathHelper.getSelectionIndex(0.25, dotsPlaces), equals(1));
    });

    test("when nearby value is selected on left return place value", () {
      expect(MathHelper.getSelectionIndex(0.223, dotsPlaces), equals(1));
    });

    test("when nearby value is selected on right return place value", () {
      expect(MathHelper.getSelectionIndex(0.293, dotsPlaces), equals(1));
    });

    test("when nearby value is selected near 1 return 1", () {
      expect(MathHelper.getSelectionIndex(0.800, dotsPlaces), equals(3));
    });
  });
}
