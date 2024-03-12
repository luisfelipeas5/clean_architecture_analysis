import 'package:clean_architecture_analysis/main.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/controllers/graph/component_graph_controller.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/file_tree/components_selected_file_tree.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/algorithm/custom_algorithm.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph/app_graph_widget.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/graph_interactive_viewer/graph_interactive_viewer.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/component_node_widget.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/node_widget.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/which_files_import_dependency/which_files_import_dependency_container.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class DependenciesGraphPage extends StatefulWidget {
  @override
  State createState() => _DependenciesGraphPageState();
}

class _DependenciesGraphPageState extends State<DependenciesGraphPage> {
  late ComponentGraphController _componentGraphController;
  final CustomAlgorithm _customAlgorithm = CustomAlgorithm(
    renderer: ArrowEdgeRenderer(),
  );

  @override
  void initState() {
    super.initState();
    _componentGraphController = ComponentGraphController(
      nodeWidth: NodeWidget.width,
      nodeHeight: 75,
      setComponentsGraphNodePositions: appDependencyInjector(),
      filterGraphComponents: appDependencyInjector(),
    );
    _loadGraph();
  }

  void _loadGraph() async {
    final getComponentsWithDependencies =
        appDependencyInjector<GetComponentsWithDependencies>();
    final result = await getComponentsWithDependencies();
    if (result.isFail()) return print("❌ Failed to get dependencies.");

    final List<ComponentWithDependencies> componentWithDependenciesList =
        result.data!;
    _componentGraphController.load(
      componentWithDependenciesList: componentWithDependenciesList,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (_componentGraphController.hasComponentSelected)
            Expanded(
              flex: 1,
              child: _buildComponentSelectedFileTreeWidget(),
            ),
          if (_componentGraphController.componentWithDepSelected != null) ...[
            Expanded(
              flex: 1,
              child: _buildWhichFilesImportDependencyContainer(),
            ),
            Spacer(),
          ],
          if (_componentGraphController.componentWithDepSelected == null)
            Expanded(
              flex: 2,
              child: _buildBody(),
            ),
        ],
      ),
    );
  }

  Widget _buildComponentSelectedFileTreeWidget() {
    return ComponentsSelectedFileTree(
      components: _componentGraphController.seletedComponents,
      componentWithDependenciesClicked: _componentGraphController
          .componentNodeClicked!.componentWithDependencies,
      onDependencyTap: _onDependencyTap,
    );
  }

  void _onDependencyTap(
    ComponentWithDependencies componentWithDep,
    ComponentDependency dependency,
  ) {
    setState(() {
      _componentGraphController.onDependencyTap(
        componentWithDep,
        dependency,
      );
    });
  }

  Widget _buildBody() {
    if (_componentGraphController.graph.nodes.isEmpty) return _buildLoader();
    return GraphInteractiveViewer(
      customAlgorithm: _customAlgorithm,
      graph: _componentGraphController.graph,
      child: _buildAppGraph(),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildAppGraph() {
    return AppGraphWidget(
      graph: _componentGraphController.graph,
      customAlgorithm: _customAlgorithm,
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
    _componentGraphController.onComponentNodeTap(componentNode);
    setState(() {});
  }

  Widget _buildWhichFilesImportDependencyContainer() {
    return WhichFilesImportDependencyContainer(
      componentWithDependencies:
          _componentGraphController.componentWithDepSelected!,
      componentDependency: _componentGraphController.dependencySelected!,
      onCloseTap: () {
        _componentGraphController.onDependencyTap(null, null);
        setState(() {});
      },
    );
  }
}
