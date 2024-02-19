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

  late Map<int, double> xOffsetByOrder;
  late double nodeWidth, nodeHeight, nodeMargin;
  late Map<int, OrderCircuference> orderCircuferences;

  Result<List<ComponentNodePosition>> call({
    required List<ComponentWithDependencies> components,
    required double nodeWidth,
    required double nodeHeight,
    required double nodeMargin,
  }) {
    xOffsetByOrder = <int, double>{};
    this.nodeWidth = nodeWidth;
    this.nodeHeight = nodeHeight;
    this.nodeMargin = nodeMargin;
    orderCircuferences = getOrderCircuferences(
      componentsWithDependencies: components,
    ).data!;

    components.sort(_sortComponents);
    final componentNodePositions = components.map((component) {
      return _getPosition(
        componentWithDependencies: component,
        components: components,
      );
    }).toList();
    return Result.success(componentNodePositions);
  }

  int _sortComponents(
      ComponentWithDependencies a, ComponentWithDependencies b) {
    final aOrder = a.component.type?.order ?? -1;
    final bOrder = b.component.type?.order ?? -1;
    return aOrder - bOrder;
  }

  ComponentNodePosition _getPosition({
    required ComponentWithDependencies componentWithDependencies,
    required List<ComponentWithDependencies> components,
  }) {
    final (x, y) = _getComponentPosition(
      component: componentWithDependencies.component,
    );

    final order = componentWithDependencies.component.type?.order ?? -1;
    _incrementXOffsetOrder(
      order: order,
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
    final x = xOffsetByOrder[order] ?? 0;
    final y = (order * nodeHeight) + nodeMargin;
    return (x, y);
  }

  void _incrementXOffsetOrder({
    required int order,
  }) {
    final xOffsetOrder = xOffsetByOrder[order] ?? 0;
    xOffsetByOrder[order] = xOffsetOrder + nodeWidth + nodeMargin;
  }
}
