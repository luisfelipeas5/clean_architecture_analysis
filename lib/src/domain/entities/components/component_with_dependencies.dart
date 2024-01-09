import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';

class ComponentWithDependencies {
  final Component component;
  final List<ComponentDependency> dependencies;

  const ComponentWithDependencies({
    required this.component,
    required this.dependencies,
  });
}
