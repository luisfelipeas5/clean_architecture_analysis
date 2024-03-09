import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/app/app_dependency_injector.dart';
import 'package:clean_architecture_analysis/src/data/repositories/analysis_config/analysis_config_repository_impl.dart';
import 'package:clean_architecture_analysis/src/data/repositories/file_system/file_system_repository_impl.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/analysis_config/analysis_config_repository.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/file_system/file_system_repository.dart';

class SetUpRepositoriesDependencyInjections {
  final AppDependencyInjector injector;
  final bool debugMode;

  SetUpRepositoriesDependencyInjections({
    required this.injector,
    required this.debugMode,
  });

  void call() {
    injector.putSingleton<FileSystemRepository>((injector) {
      return FileSystemRepositoryImpl(
        fileSystemDataSource: injector(),
        debugMode: debugMode,
      );
    });

    injector.putSingleton<AnalysisConfigRepository>((injector) {
      return AnalysisConfigRepositoryImpl(
        analysisConfigLocalDataSource: injector(),
        fileSystemDataSource: injector(),
        debugMode: debugMode,
      );
    });
  }
}
