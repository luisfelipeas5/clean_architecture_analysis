import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/extensions/component_type_presentation_extensions.dart';
import 'package:flutter/material.dart';

class ComponentSliverFileStree extends StatelessWidget {
  final ComponentWithDependencies componentWithDependencies;
  final bool expanded;
  final Function(ComponentWithDependencies componentWithDependencies)
      onComponentTap;

  const ComponentSliverFileStree({
    required this.componentWithDependencies,
    required this.expanded,
    required this.onComponentTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final component = componentWithDependencies.component;
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => onComponentTap(componentWithDependencies),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          decoration: _getDecoration(),
          child: _buildColumn(component, context),
        ),
      ),
    );
  }

  Column _buildColumn(Component component, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          component.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (expanded)
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "has following dependencies: ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }

  BoxDecoration _getDecoration() {
    final component = componentWithDependencies.component;
    return BoxDecoration(
      color: component.type?.backgroundColor,
      border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }
}
