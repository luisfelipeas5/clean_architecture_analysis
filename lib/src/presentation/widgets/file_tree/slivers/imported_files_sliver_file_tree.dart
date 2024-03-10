import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:flutter/material.dart';

class ImportedFilesSliverFileTree extends StatelessWidget {
  final ComponentDependency dependency;

  const ImportedFilesSliverFileTree({
    required this.dependency,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final importedFiles = dependency.importedFiles;
    return SliverList.builder(
      itemCount: importedFiles.length,
      itemBuilder: (context, index) {
        final file = importedFiles[index];
        return Container(
          margin: EdgeInsets.only(left: 32),
          child: Text(file.relativePath),
        );
      },
    );
  }
}
