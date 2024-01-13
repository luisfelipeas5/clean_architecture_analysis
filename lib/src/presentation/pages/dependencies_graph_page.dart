import 'package:clean_architecture_analysis/main.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/app_graph.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/node_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class DependenciesGraphPage extends StatefulWidget {
  @override
  State createState() => _DependenciesGraphPageState();
}

class _DependenciesGraphPageState extends State<DependenciesGraphPage> {
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    _loadGraph();
  }

  void _loadGraph() async {
    final getComponentsWithDependencies =
        appDependencyInjector<GetComponentsWithDependencies>();
    final result = await getComponentsWithDependencies();
    if (result.isFail()) return print("❌ Failed to get dependencies.");

    final List<ComponentWithDependencies> componentWithDependenciesList =
        result.data!;
    final nodes = componentWithDependenciesList.map(_mapComponentToNode);
    for (var node in nodes) {
      _addEdges(
        node: node,
        nodes: nodes,
      );
    }

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: graph.nodes.isEmpty ? _buildLoader() : _buildAppGraph(),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  AppGraph _buildAppGraph() {
    return AppGraph(
      graph: graph,
      builder: builder,
      nodeWidgetBuilder: (Node node) {
        final ComponentWithDependencies componentWithDependencies =
            node.key!.value as ComponentWithDependencies;
        return NodeWidget(
          text: componentWithDependencies.component.name,
        );
      },
    );
  }

  Node _mapComponentToNode(
    ComponentWithDependencies componentWithDependencies,
  ) {
    return Node.Id(componentWithDependencies);
  }

  void _addEdges({
    required Node node,
    required Iterable<Node> nodes,
  }) {
    final ComponentWithDependencies componentWithDependencies = node.key!.value;
    for (var dependency in componentWithDependencies.dependencies) {
      final dependencyNode = nodes.getDependencyNode(dependency);
      if (dependencyNode != null) {
        graph.addEdge(node, dependencyNode);
      }
    }
  }
}

extension _NodeExtension on Iterable<Node> {
  Node? getDependencyNode(ComponentDependency dependency) {
    for (var node in this) {
      final ComponentWithDependencies componentWithDependenciesNode =
          node.key!.value;
      final componentNode = componentWithDependenciesNode.component;
      if (componentNode.name == dependency.component.name) {
        return node;
      }
    }
    return null;
  }
}
