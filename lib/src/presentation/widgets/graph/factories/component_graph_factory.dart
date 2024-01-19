import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:graphview/GraphView.dart';

class ComponentGraphFactory {
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  final xOffsetByOrder = <int, double>{};

  void load(
    List<ComponentWithDependencies> componentWithDependenciesList,
  ) {
    final nodes = componentWithDependenciesList
        .where(_filterNodes)
        .map(_mapComponentToNode);

    _addNodeAndItsPosition(nodes);
    _addAllEdges(nodes);

    builder
      ..levelSeparation = 100
      ..siblingSeparation = 500
      ..subtreeSeparation = 500
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP;
  }

  bool _filterNodes(ComponentWithDependencies componentWithDependencies) {
    final order = componentWithDependencies.component.type?.order ?? 0;
    return order <= 0;
  }

  void _addNodeAndItsPosition(Iterable<ComponentNode> nodes) {
    for (var node in nodes) {
      graph.addNode(node);
      _setUpNodePosition(node);

      final order = node.order ?? -1;
      _incrementXOffsetOrder(order);
    }
  }

  void _addAllEdges(Iterable<ComponentNode> nodes) {
    for (var node in nodes) {
      _addEdges(
        node: node,
        nodes: nodes,
      );
    }
  }

  void _incrementXOffsetOrder(int order) {
    final xOffsetOrder = xOffsetByOrder[order] ?? 0;
    xOffsetByOrder[order] = xOffsetOrder + 5;
  }

  void _addEdges({
    required ComponentNode node,
    required Iterable<ComponentNode> nodes,
  }) {
    for (var dependency in node.dependencies) {
      final dependencyNode = nodes.getDependencyNode(dependency);
      if (dependencyNode != null) {
        graph.addEdge(node, dependencyNode);
      }
    }
  }

  void _setUpNodePosition(ComponentNode node) {
    final order = node.order ?? -1;
    node.x = xOffsetByOrder[order] ?? 0;
    node.y = node.order?.toDouble() ?? 0.0;
  }

  ComponentNode _mapComponentToNode(
    ComponentWithDependencies componentWithDependencies,
  ) {
    return ComponentNode(
      componentWithDependencies: componentWithDependencies,
    );
  }
}

extension _NodeExtension on Iterable<ComponentNode> {
  ComponentNode? getDependencyNode(ComponentDependency dependency) {
    for (var node in this) {
      final componentNode = node.component;
      if (componentNode.name == dependency.component.name) {
        return node;
      }
    }
    return null;
  }
}
