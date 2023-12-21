import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';

abstract interface class FileSystemDataSource {
  Future<List<AppFile>> getFiles({
    required String path,
    required List<String> exclude,
  });

  Future<String> getFileContent(AppFile appFile);
}
