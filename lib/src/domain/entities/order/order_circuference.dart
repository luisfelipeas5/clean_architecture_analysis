import 'dart:math';

class OrderCircuference {
  final int order;
  final double ratio;
  final (double, double) center;
  final int componentsCount;

  OrderCircuference({
    required this.order,
    required this.ratio,
    required this.center,
    required this.componentsCount,
  });

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

  double _nextAngle = 0;

  (double, double, double) getNextComponentCoordinates({
    required double? preferrableAngle,
  }) {
    // Following: https://stackoverflow.com/a/839931/4756152
    // x = cx + r * cos(a)
    // y = cy + r * sin(a)
    final (cx, cy) = center;
    final r = ratio;

    final angle = _nextAngle;
    final a = _deg2rad(angle);
    _incrementAngle();

    final x = cx + (r * cos(a));
    final y = cy + (r * sin(a));
    return (
      x,
      y,
      angle,
    );
  }

  _incrementAngle() {
    final length = 360;
    final lengthForEachComponent = length / componentsCount;
    _nextAngle = (_nextAngle + lengthForEachComponent) % length;
  }

  double _deg2rad(double deg) {
    return deg / 180.0 * pi;
  }
}
