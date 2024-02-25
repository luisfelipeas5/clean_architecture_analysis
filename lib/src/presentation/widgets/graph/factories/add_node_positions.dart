import 'package:clean_architecture_analysis/src/domain/entities/components/component_node_position.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';

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
