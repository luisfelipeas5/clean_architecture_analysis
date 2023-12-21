import 'dart:async';
import 'dart:io';

import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source.dart';
import 'package:clean_architecture_analysis/src/data/models/app_file/app_file_model.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';

class FileSystemDataSourceImpl implements FileSystemDataSource {
  @override
  Future<List<AppFile>> getFiles({
    required String path,
    required List<String> exclude,
  }) {
    final directory = Directory(path);
    final appFiles = <AppFile>[];
    final completer = Completer<List<AppFile>>();
    directory.list(recursive: true).listen(
          (file) => _addOrNotAsAppFile(
            appFiles: appFiles,
            exclude: exclude,
            fileSystemEntity: file,
            rootPath: path,
          ),
          onDone: () => completer.complete(appFiles),
        );
    return completer.future;
  }

  void _addOrNotAsAppFile({
    required FileSystemEntity fileSystemEntity,
    required List<AppFile> appFiles,
    required String rootPath,
    required List<String> exclude,
  }) {
    if (_isExcludePath(fileSystemEntity, exclude)) return;
    if (fileSystemEntity is Directory) return;

    final appFileModel = AppFileModel.fromFileSystemEntity(
      rootPath: rootPath,
      fileSystemEntity: fileSystemEntity,
    );
    appFiles.add(appFileModel);
  }

  bool _isExcludePath(
    FileSystemEntity file,
    List<String> exclude,
  ) {
    return exclude.any((excludePattern) {
      return RegExp(excludePattern).hasMatch(file.path);
    });
  }

  @override
  Future<String> getFileContent(AppFile appFile) async {
    final file = File(appFile.path);
    return await file.readAsString();
  }
}
