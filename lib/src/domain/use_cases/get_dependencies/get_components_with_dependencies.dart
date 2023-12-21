import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_dependencies.dart';

class GetComponentsWithDependencies {
  final GetComponents getComponents;
  final GetDependencies getDependencies;

  GetComponentsWithDependencies({
    required this.getComponents,
    required this.getDependencies,
  });

  Future<Result<List<ComponentWithDependencies>>> call() async {
    final componentsResult = await getComponents();
    if (componentsResult.isFail()) return componentsResult.parseFail();

    final components = componentsResult.data ?? [];
    final componentsWithDependencies = <ComponentWithDependencies>[];
    for (var component in components) {
      final (result, dependencies) = await _getResultOrDependencies(component);
      if (result.isFail()) return result.parseFail();

      componentsWithDependencies.add(ComponentWithDependencies(
        component: component,
        dependencies: dependencies ?? [],
      ));
    }

    return Result.success(componentsWithDependencies);
  }

  Future<(Result, List<ComponentDependency>?)> _getResultOrDependencies(
    Component component,
  ) async {
    final componentWithDependenciesResult = await getDependencies(component);
    if (componentWithDependenciesResult.isFail()) {
      return (componentWithDependenciesResult, null);
    }

    final componentWithDependencies = componentWithDependenciesResult.data!;
    return (componentWithDependenciesResult, componentWithDependencies);
  }
}
