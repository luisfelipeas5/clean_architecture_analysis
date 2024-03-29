part of '../component_graph_controller.dart';

void addAllEdges({
  required Iterable<ComponentNode> nodes,
  required Graph graph,
}) {
  for (var node in nodes) {
    _addEdges(
      node: node,
      nodes: nodes,
      graph: graph,
    );
  }
}

void _addEdges({
  required ComponentNode node,
  required Iterable<ComponentNode> nodes,
  required Graph graph,
}) {
  final wrongEdgePaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  final dependencies = node.dependencies;
  for (var dependency in dependencies) {
    final dependencyNode = nodes.getDependencyNode(dependency);
    if (dependencyNode != null) {
      final wrongEdge = dependency.wrongOrder;
      if (wrongEdge) {
        node.state = NodeState.error;
        dependencyNode.state = NodeState.error;
      }
      graph.addEdge(
        node,
        dependencyNode,
        paint: wrongEdge ? wrongEdgePaint : null,
      );
    }
  }
}
