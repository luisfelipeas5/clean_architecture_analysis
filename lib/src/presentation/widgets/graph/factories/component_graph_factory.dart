import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:graphview/GraphView.dart';

const double nodeMargin = 16;

class ComponentGraphFactory {
  final double nodeWidth, nodeHeight;

  ComponentGraphFactory({
    required this.nodeWidth,
    required this.nodeHeight,
  });

  final graph = Graph()..isTree = true;
  final builder = BuchheimWalkerConfiguration();
  final xOffsetByOrder = <int, double>{};

  void load({
    required List<ComponentWithDependencies> componentWithDependenciesList,
  }) {
    final nodes = componentWithDependenciesList
        .where(_filterNodes)
        .map(_mapComponentToNode)
        .toList();

    _addNodeAndPosition(
      nodes: nodes,
    );
    _addAllEdges(nodes);

    builder
      ..levelSeparation = 100
      ..siblingSeparation = 500
      ..subtreeSeparation = 500
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP;
  }

  bool _filterNodes(ComponentWithDependencies componentWithDependencies) {
    final component = componentWithDependencies.component;
    final order = component.type?.order;
    if (order == null) return false;
    // if (component.name.contains("feature_core/")) return false;
    return true;
  }

  void _addNodeAndPosition({
    required Iterable<ComponentNode> nodes,
  }) {
    for (var node in nodes) {
      graph.addNode(node);
      _setUpNodePosition(
        node: node,
      );

      final order = node.order ?? -1;
      _incrementXOffsetOrder(
        order: order,
      );
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

  void _addEdges({
    required ComponentNode node,
    required Iterable<ComponentNode> nodes,
  }) {
    for (var dependency in node.dependencies) {
      final dependencyNode = nodes.getDependencyNode(dependency);
      if (dependencyNode != null) {
        graph.addEdge(node, dependencyNode);
        ArrowEdgeRenderer;
      }
    }
  }

  void _setUpNodePosition({
    required ComponentNode node,
  }) {
    final order = node.order ?? -1;
    node.x = xOffsetByOrder[order] ?? 0;
    node.y = (order * nodeHeight) + nodeMargin;
  }

  void _incrementXOffsetOrder({
    required int order,
  }) {
    final xOffsetOrder = xOffsetByOrder[order] ?? 0;
    xOffsetByOrder[order] = xOffsetOrder + nodeWidth + nodeMargin;
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
