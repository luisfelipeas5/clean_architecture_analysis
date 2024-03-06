import 'dart:math';

import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_node_position.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/entities/order/order_circuference.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_order_circuferences/get_order_circuferences.dart';
import 'package:clean_architecture_analysis/src/math_utils/dregress_radians.dart';

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
    components.sort(_sortByOrderAndDependenciesCount);
    for (var component in components) {
      final position = _getPosition(
        componentWithDependencies: component,
      );
      componentNodePositions.add(position);
    }

    return Result.success(componentNodePositions);
  }

  int _sortByOrderAndDependenciesCount(
    ComponentWithDependencies a,
    ComponentWithDependencies b,
  ) {
    final orderA = a.component.type?.order ?? -1;
    final orderB = b.component.type?.order ?? -1;
    if (orderA != orderB) {
      return orderA.compareTo(orderB);
    }

    final dependenciesCountA = a.dependencies.length;
    final dependenciesCountB = b.dependencies.length;
    return dependenciesCountB.compareTo(dependenciesCountA);
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

    final dependenciesAngleAverage = _getDependenciesAngleAverage(
      componentWithDependencies,
    );
    final coordinates = orderCircuference.getNextComponentCoordinates(
      preferrableAngle: dependenciesAngleAverage,
    );

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

    //follow "average angle" algorithm from: https://stackoverflow.com/a/491784/4756152
    double cosSum = 0;
    double sinSum = 0;
    for (var angle in dependenciesAngles) {
      final radians = degressToRadians(angle);
      cosSum += cos(radians);
      sinSum += sin(radians);
    }
    final averageAngleRadians = atan2(sinSum, cosSum);
    final averageAngleDegress = radiansToDegress(averageAngleRadians);
    if (averageAngleDegress >= 0) return averageAngleDegress;
    return 360 + averageAngleDegress;
  }

  ComponentNodePosition _mapFirstNodePosition(ComponentDependency dependency) {
    return componentNodePositions.firstWhere((position) {
      return position.component.name == dependency.component.name;
    });
  }
}
