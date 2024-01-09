import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/file_system/file_system_repository.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_import.dart';

class GetDependenciesByFile {
  final GetComponentByImport getComponentByImport;
  final FileSystemRepository fileSystemRepository;

  const GetDependenciesByFile({
    required this.getComponentByImport,
    required this.fileSystemRepository,
  });

  Future<Result<List<ComponentDependency>>> call({
    required Component component,
    required AppFile appFile,
    required List<ComponentType> types,
  }) async {
    final contentResult = await fileSystemRepository.getFileContent(appFile);
    if (contentResult.isFail()) return contentResult.parseFail();

    final content = contentResult.data!;
    final imports = _getImports(content);

    final componentDependencies = <ComponentDependency>[];
    for (var import in imports) {
      final componentByImportResult =
          await getComponentByImport(import: import, types: types);
      if (componentByImportResult.isFail()) {
        return componentByImportResult.parseFail();
      }

      final componentByImport = componentByImportResult.data;
      if (!_isDependencyValid(
        component: component,
        dependency: componentByImport,
      )) {
        continue;
      }

      final componentDependency = ComponentDependency(
        component: componentByImport!,
      );
      if (componentDependencies.contains(componentDependency)) continue;
      componentDependencies.add(componentDependency);
    }
    return Result.success(componentDependencies);
  }

  bool _isDependencyValid({
    required Component component,
    required Component? dependency,
  }) {
    return dependency != null &&
        dependency.type != null &&
        dependency.name != component.name;
  }

  List<String> _getImports(String content) {
    final importRegex = RegExp("import ['\"](.*)['\"]");
    final matches = importRegex.allMatches(content);
    return matches
        .map((match) => match.group(1))
        .where((element) => element != null)
        .cast<String>()
        .toList();
  }
}
