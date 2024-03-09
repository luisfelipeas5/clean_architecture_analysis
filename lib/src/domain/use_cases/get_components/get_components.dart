import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/file_system/file_system_repository.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_analysis_config/get_analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_file.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_types.dart';

class GetComponents {
  final FileSystemRepository fileSystemRepository;
  final GetComponentByFile getComponentByFile;
  final GetComponentTypes getComponentTypes;
  final GetAnalysisConfig getAnalysisConfig;

  GetComponents({
    required this.getComponentByFile,
    required this.getComponentTypes,
    required this.fileSystemRepository,
    required this.getAnalysisConfig,
  });

  Future<Result<List<Component>>> call() async {
    final analysisConfigResult = await getAnalysisConfig();
    if (analysisConfigResult.isFail()) return analysisConfigResult.parseFail();

    final analysisConfig = analysisConfigResult.data!;
    final filesResult = await fileSystemRepository.getFiles(analysisConfig);
    if (filesResult.isFail()) return filesResult.parseFail();

    final typesResult = await getComponentTypes();
    if (typesResult.isFail()) return typesResult.parseFail();

    final types = typesResult.data!;
    final files = filesResult.data;
    final components = await _getComponentsByFiles(files, types);
    return Result.success(components);
  }

  Future<List<Component>> _getComponentsByFiles(
    List<AppFile>? files,
    List<ComponentType> types,
  ) async {
    final components = <Component>[];
    for (var file in files ?? []) {
      final componentResult = await getComponentByFile(
        file: file,
        types: types,
      );
      if (componentResult.isFail()) continue;

      final component = componentResult.data!;

      if (components.contains(component)) {
        _appendAppFiles(components, component);
        continue;
      }
      components.add(component);
    }

    return components;
  }

  void _appendAppFiles(List<Component> components, Component component) {
    final existedComponent = components.firstWhere(
      (element) => element.name == component.name,
    );
    existedComponent.appFiles.addAll(component.appFiles);
  }
}
