import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/typedefs/component_callback.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/file_tree/slivers/component_sliver_file_tree.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/file_tree/slivers/dependency_sliver_file_tree.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/file_tree/slivers/imported_files_sliver_file_tree.dart';
import 'package:flutter/material.dart';

class ComponentsSelectedFileTree extends StatefulWidget {
  final List<ComponentWithDependencies> components;
  final ComponentWithDependencies componentWithDependenciesClicked;
  final ComponentDependencyCallback onDependencyTap;

  const ComponentsSelectedFileTree({
    required this.components,
    required this.componentWithDependenciesClicked,
    required this.onDependencyTap,
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
  void initState() {
    super.initState();
    expandedMap[widget.componentWithDependenciesClicked] = true;
  }

  @override
  void didUpdateWidget(covariant ComponentsSelectedFileTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    final sameComponents = !widget.components.any((component) {
      return !oldWidget.components.contains(component);
    });
    if (!sameComponents) {
      expandedMap.clear();
    }
    expandedMap[widget.componentWithDependenciesClicked] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      ),
      child: CustomScrollView(
        slivers: _slivers,
      ),
    );
  }


  List<Widget> get _slivers {
    final slivers = List<Widget>.empty(growable: true);
    for (var component in widget.components) {
      final expanded = expandedMap[component] ?? false;

      slivers.add(_buildComponentSliver(component, expanded));
      slivers.add(_buildSeparator(2));

      if (expanded) {
        slivers.addAll(_buildDependenciesSlivers(component));
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
      slivers.add(
        _buildDependencySliver(componentWithDependencies, dependency),
      );
      slivers.add(
        _buildImportedFilesSliver(componentWithDependencies, dependency),
      );
      slivers.add(SliverToBoxAdapter(child: SizedBox(height: 16)));
      slivers.add(_buildSeparator(1));
    }
    slivers.add(_buildSeparator(1));
    return slivers;
  }

  Widget _buildComponentSliver(
    ComponentWithDependencies componentWithDep,
    bool expanded,
  ) {
    return ComponentSliverFileStree(
      componentWithDependencies: componentWithDep,
      onComponentTap: _onComponentTap,
    );
  }

  void _onComponentTap(ComponentWithDependencies componentWithDep) {
    setState(() {
      final expanded = expandedMap[componentWithDep] ?? false;
      expandedMap[componentWithDep] = !expanded;
    });
  }

  Widget _buildDependencySliver(
    ComponentWithDependencies componentWithDep,
    ComponentDependency dependency,
  ) {
    return DependencySliverFileTree(
      componentWithDep: componentWithDep,
      dependency: dependency,
      onTap: widget.onDependencyTap,
    );
  }

  Widget _buildImportedFilesSliver(
    ComponentWithDependencies componentWithDep,
    ComponentDependency dependency,
  ) {
    return ImportedFilesSliverFileTree(
      componentWithDep: componentWithDep,
      dependency: dependency,
      onTap: widget.onDependencyTap,
    );
  }

  Widget _buildSeparator(double size) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.black,
        height: size,
      ),
    );
  }
}
