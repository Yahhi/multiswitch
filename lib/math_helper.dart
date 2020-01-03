import 'dart:math';
import 'dart:ui';

class MathHelper {
  static double transformOffsetToCirclePercent(
      Offset localPosition, Offset circleCenter, double circleRadius) {
    final Offset vector0 = Offset(0.0, -100.0);
    final Offset vectorOfPosition = localPosition - circleCenter;
    final double cosValue = (vector0.dx * vectorOfPosition.dx +
            vector0.dy * vectorOfPosition.dy) /
        (sqrt(pow(vector0.dx, 2) + pow(vector0.dy, 2)) *
            sqrt(pow(vectorOfPosition.dy, 2) + pow(vectorOfPosition.dx, 2)));
    final double angle = acos(cosValue);
    if (vectorOfPosition.dx >= 0)
      return angle / (2 * pi);
    else
      return 1 - angle / (2 * pi);
  }

  static int getSelectionIndex(double percent, List<double> radianValues) {
    double minDifference = 1;
    int index = 0;
    print("calculating for $percent");
    for (int i = 0; i < radianValues.length; i++) {
      final double value = radianValues[i];
      double difference = ((value / (2 * pi)) - percent).abs();
      print("difference $difference for value $value");
      if (minDifference > difference) {
        print("it is min");
        minDifference = difference;
        index = i;
      }
    }
    return index;
  }
}
