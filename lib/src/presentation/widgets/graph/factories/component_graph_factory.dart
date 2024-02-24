import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_node_position.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/filter_components_graph/filter_components_graph.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/set_components_graph_node_positions/set_components_graph_node_positions.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:graphview/GraphView.dart';

const double nodeMargin = 16;

class ComponentGraphFactory {
  final double nodeWidth, nodeHeight;
  final FilterComponentsGraph filterGraphComponents;
  final SetComponentsGraphNodePositions setComponentsGraphNodePositions;

  ComponentGraphFactory({
    required this.nodeWidth,
    required this.nodeHeight,
    required this.setComponentsGraphNodePositions,
    required this.filterGraphComponents,
  });

  late Graph graph = Graph();

  void load({
    required List<ComponentWithDependencies> componentWithDependenciesList,
  }) {
    graph = Graph();

    final filteredComponents =
        filterGraphComponents(components: componentWithDependenciesList).data!;

    final positions = setComponentsGraphNodePositions(
      components: filteredComponents,
    ).data!;

    final nodes =
        filteredComponents.map(_mapComponentToNode).toList();

    _addNodes(nodes: nodes);
    _addNodePositions(
      positions: positions,
      nodes: nodes,
    );
    _addAllEdges(nodes);
  }

  void _addNodes({
    required Iterable<ComponentNode> nodes,
  }) {
    for (var node in nodes) {
      graph.addNode(node);
    }
  }

  void _addNodePositions({
    required List<ComponentNodePosition> positions,
    required Iterable<ComponentNode> nodes,
  }) {
    for (var position in positions) {
      final node = nodes
          .where((node) => node.component == position.component)
          .firstOrNull;
      node?.x = position.x;
      node?.y = position.y;
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
    final dependencies = node.dependencies;
    for (var dependency in dependencies) {
      final dependencyNode = nodes.getDependencyNode(dependency);
      if (dependencyNode != null) {
        graph.addEdge(node, dependencyNode);
      }
    }
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
