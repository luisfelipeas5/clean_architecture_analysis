import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:graphview/GraphView.dart';

class ComponentNode extends Node {
  final ComponentWithDependencies componentWithDependencies;

  ComponentNode({
    required this.componentWithDependencies,
  }) : super.Id(componentWithDependencies);

  Component get component {
    return componentWithDependencies.component;
  }

  List<ComponentDependency> get dependencies {
    return componentWithDependencies.dependencies;
  }

  int? get order {
    return componentWithDependencies.component.type?.order;
  }
}