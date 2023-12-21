import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';

abstract interface class FileSystemRepository {
  Future<Result<List<AppFile>>> getFiles(AnalysisConfig analysisConfig);
  Future<Result<String>> getFileContent(AppFile appFile);
}
