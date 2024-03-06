part of '../component_graph_controller.dart';

void addNodePositions({
  required List<ComponentNodePosition> positions,
  required Iterable<ComponentNode> nodes,
}) {
  for (var position in positions) {
    final node = nodes
        .where(
          (node) => node.component == position.component,
        )
        .firstOrNull;
    node?.x = position.x;
    node?.y = position.y;
  }
}
