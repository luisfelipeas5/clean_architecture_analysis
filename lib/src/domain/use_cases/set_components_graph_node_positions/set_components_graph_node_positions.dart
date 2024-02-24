import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_node_position.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/entities/order/order_circuference.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_order_circuferences/get_order_circuferences.dart';

class SetComponentsGraphNodePositions {
  final GetOrderCircuferences getOrderCircuferences;

  SetComponentsGraphNodePositions({
    required this.getOrderCircuferences,
  });

  late List<ComponentWithDependencies> components;
  late Map<int, OrderCircuference> orderCircuferences;
  late List<ComponentNodePosition> componentNodePositions;

  Result<List<ComponentNodePosition>> call({
    required List<ComponentWithDependencies> components,
  }) {
    this.components = components;
    orderCircuferences = getOrderCircuferences(
      componentsWithDependencies: components,
    ).data!;

    componentNodePositions = List.empty(growable: true);
    for (var component in components) {
      final position = _getPosition(
        componentWithDependencies: component,
      );
      componentNodePositions.add(position);
    }

    return Result.success(componentNodePositions);
  }

  ComponentNodePosition _getPosition({
    required ComponentWithDependencies componentWithDependencies,
  }) {
    final (x, y, angle) = _getComponentPosition(
      componentWithDependencies: componentWithDependencies,
    );

    return ComponentNodePosition(
      component: componentWithDependencies.component,
      x: x,
      y: y,
      angle: angle,
    );
  }

  (double, double, double) _getComponentPosition({
    required ComponentWithDependencies componentWithDependencies,
  }) {
    final component = componentWithDependencies.component;
    final order = component.type?.order ?? -1;
    final orderCircuference = orderCircuferences[order];
    if (orderCircuference == null) return (0, 0, 0);

    print("component ${component.name}");
    final dependenciesAngleAverage = _getDependenciesAngleAverage(
      componentWithDependencies,
    );
    print("dependenciesAngleAverage $dependenciesAngleAverage");
    final coordinates = orderCircuference.getNextComponentCoordinates(
      preferrableAngle: dependenciesAngleAverage,
    );

    print("angle ${coordinates.$3}");
    print("\n");
    return coordinates;
  }

  double? _getDependenciesAngleAverage(
    ComponentWithDependencies componentWithDependencies,
  ) {
    final order = componentWithDependencies.component.type?.order ?? -1;
    final allDependencies = componentWithDependencies.dependencies;
    final filterDependencies = allDependencies.where((dependency) {
      final dependencyOrder = dependency.component.type?.order ?? -1;
      return dependencyOrder < order;
    });
    if (filterDependencies.isEmpty) return null;

    final dependenciesAngles =
        filterDependencies.map(_mapFirstNodePosition).map((e) => e.angle);
    print("dependenciesAngles $dependenciesAngles");
    final sum = dependenciesAngles.reduce((value, element) => value + element);

    return sum / filterDependencies.length;
  }

  ComponentNodePosition _mapFirstNodePosition(ComponentDependency dependency) {
    return componentNodePositions.firstWhere((position) {
      return position.component.name == dependency.component.name;
    });
  }
}
