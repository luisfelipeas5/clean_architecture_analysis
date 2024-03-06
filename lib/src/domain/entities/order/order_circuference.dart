import 'dart:math';

import 'package:clean_architecture_analysis/src/math_utils/dregress_radians.dart';

class OrderCircuference {
  final int order;
  final double ratio;
  final (double, double) center;
  final int componentsCount;
  final List<bool> anglesTaken;

  OrderCircuference({
    required this.order,
    required this.ratio,
    required this.center,
    required this.componentsCount,
  }) : anglesTaken = List.filled(componentsCount, false);

  OrderCircuference copyWith({
    double? ratio,
    (double, double)? center,
  }) {
    return OrderCircuference(
      order: order,
      ratio: ratio ?? this.ratio,
      center: center ?? this.center,
      componentsCount: componentsCount,
    );
  }

  (double, double, double) getNextComponentCoordinates({
    required double? preferrableAngle,
  }) {
    // Following: https://stackoverflow.com/a/839931/4756152
    // x = cx + r * cos(a)
    // y = cy + r * sin(a)
    final (cx, cy) = center;
    final r = ratio;

    final angle = _getNextAngle(preferrableAngle);
    final a = degressToRadians(angle);

    final x = cx + (r * cos(a));
    final y = cy + (r * sin(a));
    return (
      x,
      y,
      angle,
    );
  }

  double _getNextAngle(double? preferrableAngle) {
    final indexToStart = _getIndexToStart(preferrableAngle);

    var angleIndex = indexToStart;
    for (var i = 0; i < anglesTaken.length; i++) {
      final rightFinger = _getFingerIndexFixed(indexToStart + i);
      if (!anglesTaken[rightFinger]) {
        angleIndex = rightFinger;
        break;
      }

      final leftFinger = _getFingerIndexFixed(indexToStart - i);
      if (!anglesTaken[leftFinger]) {
        angleIndex = leftFinger;
        break;
      }
    }

    anglesTaken[angleIndex] = true;

    final lengthForEachComponent = _getLenghtForEachComponent();
    return angleIndex * lengthForEachComponent;
  }

  int _getFingerIndexFixed(int index) {
    if (index < 0) {
      return anglesTaken.length + index;
    }
    if (index >= anglesTaken.length) {
      return index - anglesTaken.length;
    }
    return index;
  }

  int _getIndexToStart(double? preferrableAngle) {
    if (preferrableAngle == null) return 0;
    final lengthForEachComponent = _getLenghtForEachComponent();
    return preferrableAngle ~/ lengthForEachComponent;
  }

  double _getLenghtForEachComponent() {
    final length = 360;
    return length / componentsCount;
  }

}
