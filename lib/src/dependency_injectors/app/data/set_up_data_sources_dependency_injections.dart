import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/app/app_dependency_injector.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source_impl.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/analysis_config_local_data_source.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/app_analysis_config_local_data_source.dart';

class SetUpDataSourcesDependencyInjections {
  final AppDependencyInjector injector;
  final String analysisConfigFilePath;

  SetUpDataSourcesDependencyInjections({
    required this.injector,
    required this.analysisConfigFilePath,
  });

  void call() {
    injector.putSingleton<FileSystemDataSource>((injector) {
      return FileSystemDataSourceImpl();
    });

    injector.putSingleton<AnalysisConfigLocalDataSource>((injector) {
      return AppAnalysisConfigLocalDataSource(
        analysisConfigFilePath: analysisConfigFilePath,
      );
    });
  }
}
