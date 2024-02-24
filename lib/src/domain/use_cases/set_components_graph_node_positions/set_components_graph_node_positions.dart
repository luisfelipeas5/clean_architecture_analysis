import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_node_position.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/entities/order/order_circuference.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_order_circuferences/get_order_circuferences.dart';

class SetComponentsGraphNodePositions {
  final GetOrderCircuferences getOrderCircuferences;

  SetComponentsGraphNodePositions({
    required this.getOrderCircuferences,
  });

  late double nodeWidth, nodeHeight, nodeMargin;
  late Map<int, OrderCircuference> orderCircuferences;

  Result<List<ComponentNodePosition>> call({
    required List<ComponentWithDependencies> components,
    required double nodeWidth,
    required double nodeHeight,
    required double nodeMargin,
  }) {
    this.nodeWidth = nodeWidth;
    this.nodeHeight = nodeHeight;
    this.nodeMargin = nodeMargin;
    orderCircuferences = getOrderCircuferences(
      componentsWithDependencies: components,
    ).data!;

    final componentNodePositions = components.map((component) {
      return _getPosition(
        componentWithDependencies: component,
        components: components,
      );
    }).toList();
    return Result.success(componentNodePositions);
  }

  ComponentNodePosition _getPosition({
    required ComponentWithDependencies componentWithDependencies,
    required List<ComponentWithDependencies> components,
  }) {
    final (x, y) = _getComponentPosition(
      component: componentWithDependencies.component,
    );

    return ComponentNodePosition(
      component: componentWithDependencies.component,
      x: x,
      y: y,
    );
  }

  (double, double) _getComponentPosition({
    required Component component,
  }) {
    final order = component.type?.order ?? -1;
    final orderCircuference = orderCircuferences[order];
    if (orderCircuference == null) return (0, 0);

    return orderCircuference.getNextComponentCoordinates();
  }

}
