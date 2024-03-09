import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_node_position.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/filter_components_graph/filter_components_graph.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/set_components_graph_node_positions/set_components_graph_node_positions.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/node_state.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

part 'controller_helpers/add_edges.dart';
part 'controller_helpers/add_node_positions.dart';
part 'controller_helpers/select_component_and_dependencies.dart';
part 'controller_helpers/unselect_components.dart';

class ComponentGraphController {
  final double nodeWidth, nodeHeight;
  final FilterComponentsGraph filterGraphComponents;
  final SetComponentsGraphNodePositions setComponentsGraphNodePositions;

  ComponentGraphController({
    required this.nodeWidth,
    required this.nodeHeight,
    required this.setComponentsGraphNodePositions,
    required this.filterGraphComponents,
  });

  late Graph graph = Graph();

  ComponentNode? _componentNodeSelected;

  bool get hasComponentSelected => _componentNodeSelected != null;

  void load({
    required List<ComponentWithDependencies> componentWithDependenciesList,
  }) {
    graph = Graph();
    _componentNodeSelected = null;

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

  void onComponentNodeTap(ComponentNode componentNode) {
    if (_componentNodeSelected == componentNode) {
      _componentNodeSelected = null;
      graph.nodes.forEach(unselectComponentsWithNull);
    } else {
      _componentNodeSelected = componentNode;
      graph.nodes.forEach(unselectComponentsWithFalse);
      selectComponent(
        graph: graph,
        componentNodeSelected: componentNode,
      );
    }
  }

  List<ComponentWithDependencies> get seletedComponents {
    return graph.nodes
        .where(
          (node) => (node as ComponentNode).selected == true,
        )
        .map(
          (node) => (node as ComponentNode).componentWithDependencies,
        )
        .toList();
  }
}
