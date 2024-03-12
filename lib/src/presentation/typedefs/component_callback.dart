import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';

typedef ComponentDependencyCallback = void Function(
  ComponentWithDependencies componentWithDep,
  ComponentDependency dependency,
);
