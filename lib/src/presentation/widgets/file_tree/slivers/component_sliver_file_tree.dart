import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:flutter/material.dart';

class ComponentSliverFileStree extends StatelessWidget {
  final ComponentWithDependencies componentWithDependencies;

  const ComponentSliverFileStree({
    required this.componentWithDependencies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final component = componentWithDependencies.component;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(component.name),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text("has following dependencies: "),
          ),
        ],
      ),
    );
  }
}
