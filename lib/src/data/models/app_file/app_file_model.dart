import 'dart:io';

import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';

class AppFileModel extends AppFile {
  const AppFileModel._({
    required super.rootPath,
    required super.path,
  });

  factory AppFileModel.fromFileSystemEntity({
    required String rootPath,
    required FileSystemEntity fileSystemEntity,
  }) {
    return AppFileModel._(
      rootPath: rootPath,
      path: fileSystemEntity.path,
    );
  }
}
