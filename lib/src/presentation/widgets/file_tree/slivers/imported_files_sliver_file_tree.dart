import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/typedefs/component_callback.dart';
import 'package:flutter/material.dart';

class ImportedFilesSliverFileTree extends StatelessWidget {
  final ComponentWithDependencies componentWithDep;
  final ComponentDependency dependency;
  final ComponentDependencyCallback onTap;

  const ImportedFilesSliverFileTree({
    required this.componentWithDep,
    required this.dependency,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final importedFiles = dependency.importedFiles;
    return SliverList.builder(
      itemCount: importedFiles.length,
      itemBuilder: (context, index) {
        final file = importedFiles[index];
        return GestureDetector(
          onTap: () => onTap(componentWithDep, dependency),
          child: Container(
            margin: EdgeInsets.only(left: 32),
            child: Text(file.relativePath),
          ),
        );
      },
    );
  }
}
