import 'package:clean_architecture_analysis/src/domain/entities/components/component_type_pattern.dart';

class ComponentType {
  final String name;
  final List<ComponentTypePattern> patterns;
  final int order;

  const ComponentType({
    required this.name,
    required this.patterns,
    required this.order,
  });
}
