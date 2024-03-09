import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_analysis_config/get_analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_relative_path.dart';

class GetComponentByImport {
  final GetComponentByRelativePath getComponentByRelativePath;
  final GetAnalysisConfig getAnalysisConfig;

  GetComponentByImport({
    required this.getComponentByRelativePath,
    required this.getAnalysisConfig,
  });

  Future<Result<Component>> call({
    required String import,
    required List<ComponentType> types,
  }) async {
    final (fromPackageResult, fromPackage) = await _isFromPackage(import);
    if (fromPackageResult.isFail()) return fromPackageResult.parseFail();
    if (!fromPackage) return Result.success(null);

    final relativePath = _getRelativePath(import);
    final componentResult = await getComponentByRelativePath(
      relativePath: relativePath,
      types: types,
    );
    if (componentResult.isFail()) return componentResult;

    return Result.success(componentResult.data);
  }

  String _getRelativePath(String import) {
    final relativePathRegex = RegExp(".*:(.*)");
    final match = relativePathRegex.firstMatch(import);
    return match?.group(1) ?? "";
  }

  Future<(Result, bool)> _isFromPackage(String import) async {
    final analysisConfigResult = await getAnalysisConfig();
    if (analysisConfigResult.isFail()) return (analysisConfigResult, false);

    final analysisConfig = analysisConfigResult.data!;
    final packageName = analysisConfig.packageName;
    final fromPackage = import.startsWith("package:$packageName/");
    return (analysisConfigResult, fromPackage);
  }
}
