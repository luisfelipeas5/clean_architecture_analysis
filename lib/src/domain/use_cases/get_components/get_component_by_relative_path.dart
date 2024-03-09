import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/file_system/file_system_repository.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_analysis_config/get_analysis_config.dart';

class GetComponentByRelativePath {
  final FileSystemRepository fileSystemRepository;
  final GetAnalysisConfig getAnalysisConfig;

  GetComponentByRelativePath({
    required this.getAnalysisConfig,
    required this.fileSystemRepository,
  });

  Future<Result<Component>> call({
    required String relativePath,
    required List<ComponentType> types,
  }) async {
    final analysisConfigResult = await getAnalysisConfig();
    if (analysisConfigResult.isFail()) return analysisConfigResult.parseFail();

    final analysisConfig = analysisConfigResult.data!;
    final fileResult = await fileSystemRepository.getFile(
      rootPath: analysisConfig.path,
      relativePath: _getNormalizedRelativePath(relativePath, analysisConfig),
    );
    if (fileResult.isFail()) return fileResult.parseFail();

    final type = _getType(relativePath, types);
    final name = _getName(relativePath, type);

    final component = Component(
      name: name,
      type: type,
      appFiles: [
        fileResult.data!,
      ],
    );

    return Result.success(component);
  }

  String _getNormalizedRelativePath(
    String relativePath,
    AnalysisConfig analysisConfig,
  ) {
    return relativePath
        .replaceFirst("${analysisConfig.packageName}/", "")
        .replaceFirst("src/", "");
  }

  ComponentType? _getType(String relativePath, List<ComponentType> types) {
    for (var type in types) {
      for (var pattern in type.patterns) {
        final regex = pattern.regex;
        if (regex.hasMatch(relativePath)) return type;
      }
    }
    return null;
  }

  String _getName(String relativePath, ComponentType? type) {
    if (type == null) return relativePath;

    for (var pattern in type.patterns) {
      final match = pattern.regex.firstMatch(relativePath);
      if (match == null) continue;

      String name = pattern.name;
      for (var groupIndex = 0; groupIndex <= match.groupCount; groupIndex++) {
        final group = match.group(groupIndex)!;
        name = name.replaceAll("\${$groupIndex}", group);
      }
      return name;
    }

    return relativePath;
  }
}
