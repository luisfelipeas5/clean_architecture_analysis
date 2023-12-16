import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/file_system/file_system_repository.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_analysis_config/get_analysis_config.dart';

class GetComponentTypes {
  final FileSystemRepository fileSystemRepository;
  final GetAnalysisConfig getAnalysisConfig;

  GetComponentTypes({
    required this.fileSystemRepository,
    required this.getAnalysisConfig,
  });

  Future<Result<List<ComponentType>>> call() async {
    final analysisConfigResult = await getAnalysisConfig();
    if (analysisConfigResult.isFail()) analysisConfigResult.parseFail();

    final analysisConfig = analysisConfigResult.data!;
    return Result.success(analysisConfig.componentTypes);
  }
}
