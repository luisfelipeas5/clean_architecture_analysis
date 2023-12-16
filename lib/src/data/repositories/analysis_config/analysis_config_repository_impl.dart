import 'dart:async';

import 'package:clean_architecture_analysis/src/architecture_core/data/repositories/base_repository.dart';
import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/analysis_config_local_data_source.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/analysis_config/analysis_config_repository.dart';

class AnalysisConfigRepositoryImpl extends BaseRepository
    implements AnalysisConfigRepository {
  final FileSystemDataSource fileSystemDataSource;
  final AnalysisConfigLocalDataSource analysisConfigLocalDataSource;

  AnalysisConfigRepositoryImpl({
    required this.analysisConfigLocalDataSource,
    required this.fileSystemDataSource,
    required super.debugMode,
  });

  @override
  Future<Result<AnalysisConfig>> getAnalysisConfig() {
    return getResultBy(() {
      return analysisConfigLocalDataSource.getAnalysisConfig();
    });
  }
}
