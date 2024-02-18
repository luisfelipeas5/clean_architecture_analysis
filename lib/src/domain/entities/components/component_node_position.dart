import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';

class ComponentNodePosition {
  final Component component;
  final double x, y;

  ComponentNodePosition({
    required this.component,
    required this.x,
    required this.y,
  });
}
