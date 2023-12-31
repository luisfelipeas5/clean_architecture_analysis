import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_types.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_dependencies_by_file.dart';

class GetDependencies {
  final GetDependenciesByFile getDependenciesByFile;
  final GetComponentTypes getComponentTypes;

  GetDependencies({
    required this.getDependenciesByFile,
    required this.getComponentTypes,
  });

  Future<Result<List<ComponentDependency>>> call(Component component) async {
    final typesResult = await getComponentTypes();
    if (typesResult.isFail()) return typesResult.parseFail();

    final types = typesResult.data!;
    final dependencies = <ComponentDependency>[];
    for (var appFile in component.appFiles) {
      final result = await getDependenciesByFile(
        component: component,
        appFile: appFile,
        types: types,
      );
      if (result.isFail()) return result.parseFail();

      final dependenciesByFile = result.data ?? [];
      for (var dependency in dependenciesByFile) {
        if (dependencies.contains(dependency)) continue;
        dependencies.add(dependency);
      }
    }

    dependencies.sort(_compareDependencies);

    return Result.success(dependencies);
  }

  int _compareDependencies(ComponentDependency a, ComponentDependency b) {
    return a.component.name.compareTo(b.component.name);
  }
}
