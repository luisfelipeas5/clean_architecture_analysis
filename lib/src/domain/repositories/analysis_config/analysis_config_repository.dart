import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';

abstract interface class AnalysisConfigRepository {
  Future<Result<AnalysisConfig>> getAnalysisConfig();
}
