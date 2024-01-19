import 'package:clean_architecture_analysis/main.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/app_graph.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/factories/component_graph_factory.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/node_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class DependenciesGraphPage extends StatefulWidget {
  @override
  State createState() => _DependenciesGraphPageState();
}

class _DependenciesGraphPageState extends State<DependenciesGraphPage> {
  final componentGraphFactory = ComponentGraphFactory();

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
    componentGraphFactory.load(componentWithDependenciesList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (componentGraphFactory.graph.nodes.isEmpty) return _buildLoader();
    return _buildAppGraph();
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  AppGraph _buildAppGraph() {
    return AppGraph(
      graph: componentGraphFactory.graph,
      builder: componentGraphFactory.builder,
      nodeWidgetBuilder: (Node node) {
        final ComponentWithDependencies componentWithDependencies =
            node.key!.value as ComponentWithDependencies;
        return NodeWidget(
          text: componentWithDependencies.component.name,
        );
      },
    );
  }

}


