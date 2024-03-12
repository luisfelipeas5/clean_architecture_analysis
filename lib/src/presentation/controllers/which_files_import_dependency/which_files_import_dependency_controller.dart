import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';

class WhichFilesImportDependencyController {
  final ComponentWithDependencies componentWithDependencies;
  final ComponentDependency componentDependency;

  WhichFilesImportDependencyController({
    required this.componentWithDependencies,
    required this.componentDependency,
  });

  List<AppFile> files = [];

  Future<void> loadFiles() async {
    files.clear();
    files.addAll([
      AppFile(rootPath: "rootPath", path: "path"),
      AppFile(rootPath: "rootPath0", path: "path0"),
      AppFile(rootPath: "rootPath1", path: "path1"),
      AppFile(rootPath: "rootPath2", path: "path2"),
    ]);
  }
}
