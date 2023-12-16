import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/analysis_config/analysis_config_repository.dart';

class GetAnalysisConfig {
  final AnalysisConfigRepository analysisConfigRepository;

  const GetAnalysisConfig({
    required this.analysisConfigRepository,
  });

  Future<Result<AnalysisConfig>> call() async {
    return analysisConfigRepository.getAnalysisConfig();
  }
}
