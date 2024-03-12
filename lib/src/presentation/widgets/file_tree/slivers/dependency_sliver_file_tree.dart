import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/typedefs/component_callback.dart';
import 'package:flutter/material.dart';

class DependencySliverFileTree extends StatelessWidget {
  final ComponentWithDependencies componentWithDep;
  final ComponentDependency dependency;
  final ComponentDependencyCallback onTap;

  const DependencySliverFileTree({
    required this.componentWithDep,
    required this.dependency,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => onTap(componentWithDep, dependency),
        child: Container(
          margin: EdgeInsets.only(left: 16),
          child: Text(
            dependency.component.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: dependency.wrongOrder ? Colors.red : null,
                ),
          ),
        ),
      ),
    );
  }
}
