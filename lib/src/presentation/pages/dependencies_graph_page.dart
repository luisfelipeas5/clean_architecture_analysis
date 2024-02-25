import 'package:clean_architecture_analysis/main.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/app_graph.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/factories/component_graph_factory.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/component_node_widget.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/node_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class DependenciesGraphPage extends StatefulWidget {
  @override
  State createState() => _DependenciesGraphPageState();
}

class _DependenciesGraphPageState extends State<DependenciesGraphPage> {
  late ComponentGraphFactory _componentGraphFactory;
  ComponentNode? _componentNodeSelected;

  @override
  void initState() {
    super.initState();
    _componentGraphFactory = ComponentGraphFactory(
      nodeWidth: NodeWidget.width,
      nodeHeight: 75,
      setComponentsGraphNodePositions: appDependencyInjector(),
      filterGraphComponents: appDependencyInjector(),
    );
    _loadGraph();
  }

  @override
  void didUpdateWidget(covariant DependenciesGraphPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadGraph();
  }

  void _loadGraph() async {
    final getComponentsWithDependencies =
        appDependencyInjector<GetComponentsWithDependencies>();
    final result = await getComponentsWithDependencies();
    if (result.isFail()) return print("❌ Failed to get dependencies.");

    final List<ComponentWithDependencies> componentWithDependenciesList =
        result.data!;
    _componentGraphFactory.load(
      componentWithDependenciesList: componentWithDependenciesList,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_componentGraphFactory.graph.nodes.isEmpty) return _buildLoader();
    return _buildAppGraph();
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  AppGraph _buildAppGraph() {
    return AppGraph(
      graph: _componentGraphFactory.graph,
      nodeWidgetBuilder: _nodeWidgetBuilder,
    );
  }

  Widget _nodeWidgetBuilder(Node node) {
    final componentNode = node as ComponentNode;
    return ComponentNodeWidget(
      componentNode: componentNode,
      onTap: _onComponentNodeTap,
    );
  }

  void _onComponentNodeTap(ComponentNode componentNode) {
    setState(() {
      if (_componentNodeSelected == componentNode) {
        _componentNodeSelected = null;
      } else {
        _componentNodeSelected = componentNode;
      }
      _componentGraphFactory.setComponentSelected(_componentNodeSelected);
    });
  }
}
