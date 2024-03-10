import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/extensions/component_type_presentation_extensions.dart';
import 'package:flutter/material.dart';

class ComponentSliverFileStree extends StatelessWidget {
  final ComponentWithDependencies componentWithDependencies;
  final Function(ComponentWithDependencies componentWithDependencies)
      onComponentTap;

  const ComponentSliverFileStree({
    required this.componentWithDependencies,
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
          color: component.type?.backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: _buildName(component, context),
              ),
              if (_hasWrongDependencies)
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName(Component component, BuildContext context) {
    return Text(
      component.name,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  bool get _hasWrongDependencies {
    return componentWithDependencies.dependencies.any((dependency) {
      return dependency.wrongOrder;
    });
  }
}
