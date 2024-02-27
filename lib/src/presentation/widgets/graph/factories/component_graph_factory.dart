import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/filter_components_graph/filter_components_graph.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/set_components_graph_node_positions/set_components_graph_node_positions.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/factories/add_edges.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/factories/add_node_positions.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:graphview/GraphView.dart';

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

    final nodes = filteredComponents.map(_mapComponentToNode).toList();

    nodes.forEach(graph.addNode);
    addNodePositions(positions: positions, nodes: nodes);
    addAllEdges(nodes: nodes, graph: graph);
  }

  ComponentNode _mapComponentToNode(
    ComponentWithDependencies componentWithDependencies,
  ) {
    return ComponentNode(
      componentWithDependencies: componentWithDependencies,
    );
  }

  void setComponentSelected(ComponentNode? componentNodeSelected) {}
}
