import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';

abstract interface class AnalysisConfigLocalDataSource {
  Future<AnalysisConfig> getAnalysisConfig();
}
