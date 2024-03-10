import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/file_tree/slivers/component_sliver_file_tree.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/file_tree/slivers/dependency_sliver_file_tree.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/file_tree/slivers/imported_files_sliver_file_tree.dart';
import 'package:flutter/material.dart';

class ComponentsSelectedFileTree extends StatefulWidget {
  final List<ComponentWithDependencies> components;

  const ComponentsSelectedFileTree({
    required this.components,
    super.key,
  });

  @override
  State<ComponentsSelectedFileTree> createState() =>
      _ComponentsSelectedFileTreeState();
}

class _ComponentsSelectedFileTreeState
    extends State<ComponentsSelectedFileTree> {
  final Map<ComponentWithDependencies, bool> expandedMap = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _boxDecoration,
      child: CustomScrollView(
        slivers: _slivers,
      ),
    );
  }

  BoxDecoration get _boxDecoration {
    return BoxDecoration(
      border: Border(
        right: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }

  List<Widget> get _slivers {
    final slivers = List<Widget>.empty(growable: true);
    for (var component in widget.components) {
      final expanded = expandedMap[component] ?? false;

      slivers.add(_buildComponentSliver(component, expanded));

      if (expanded) {
        slivers.addAll(_buildDependenciesSlivers(component));
        slivers.add(SliverToBoxAdapter(child: SizedBox(height: 16)));
      }
    }
    return slivers;
  }

  List<Widget> _buildDependenciesSlivers(
    ComponentWithDependencies componentWithDependencies,
  ) {
    final dependencies = componentWithDependencies.dependencies;
    final slivers = List<Widget>.empty(growable: true);
    for (var dependency in dependencies) {
      slivers.add(SliverToBoxAdapter(child: SizedBox(height: 16)));
      slivers.add(_buildDependencySliver(dependency));
      slivers.add(_buildImportedFilesSliver(dependency));
    }
    return slivers;
  }

  Widget _buildComponentSliver(
    ComponentWithDependencies componentWithDep,
    bool expanded,
  ) {
    return ComponentSliverFileStree(
      componentWithDependencies: componentWithDep,
      expanded: expanded,
      onComponentTap: _onComponentTap,
    );
  }

  void _onComponentTap(ComponentWithDependencies componentWithDep) {
    setState(() {
      final expanded = expandedMap[componentWithDep] ?? false;
      expandedMap[componentWithDep] = !expanded;
    });
  }

  Widget _buildDependencySliver(ComponentDependency dependency) {
    return DependencySliverFileTree(
      dependency: dependency,
    );
  }

  Widget _buildImportedFilesSliver(ComponentDependency dependency) {
    return ImportedFilesSliverFileTree(
      dependency: dependency,
    );
  }
}
