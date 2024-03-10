import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:flutter/material.dart';

class DependencySliverFileTree extends StatelessWidget {
  final ComponentDependency dependency;

  const DependencySliverFileTree({
    required this.dependency,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 16),
        child: Text(
          dependency.component.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: dependency.wrongOrder ? Colors.red : null,
              ),
        ),
      ),
    );
  }
}
