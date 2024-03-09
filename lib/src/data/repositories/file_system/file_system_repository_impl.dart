import 'package:clean_architecture_analysis/src/architecture_core/data/repositories/base_repository.dart';
import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/file_system/file_system_repository.dart';

class FileSystemRepositoryImpl extends BaseRepository
    implements FileSystemRepository {
  final FileSystemDataSource fileSystemDataSource;

  const FileSystemRepositoryImpl({
    required this.fileSystemDataSource,
    required super.debugMode,
  });

  @override
  Future<Result<List<AppFile>>> getFiles(AnalysisConfig analysisConfig) {
    return getResultBy(() {
      return fileSystemDataSource.getFiles(
        path: analysisConfig.path,
        exclude: analysisConfig.exclude,
      );
    });
  }

  @override
  Future<Result<String>> getFileContent(AppFile appFile) {
    return getResultBy(() {
      return fileSystemDataSource.getFileContent(appFile);
    });
  }

  @override
  Future<Result<AppFile>> getFile({
    required String rootPath,
    required String relativePath,
  }) {
    return getResultBy(() {
      return fileSystemDataSource.getFile(
        rootPath: rootPath,
        relativePath: relativePath,
      );
    });
  }
}
