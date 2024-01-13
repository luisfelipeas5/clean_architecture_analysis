import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/app/app_dependency_injector.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source_impl.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/analysis_config_local_data_source.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/app_analysis_config_local_data_source.dart';
import 'package:clean_architecture_analysis/src/data/repositories/analysis_config/analysis_config_repository_impl.dart';
import 'package:clean_architecture_analysis/src/data/repositories/file_system/file_system_repository_impl.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/analysis_config/analysis_config_repository.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_analysis_config/get_analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_file.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_import.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_relative_path.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_types.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_dependencies_by_file.dart';

class SetUpDependencyInjections {
  final AppDependencyInjector appDependencyInjector;
  final bool debugMode;
  final String analysisConfigFilePath;

  SetUpDependencyInjections({
    required this.appDependencyInjector,
    required this.analysisConfigFilePath,
    required this.debugMode,
  });

  void call() {
    appDependencyInjector
        .putSingleton<GetComponentsWithDependencies>((injector) {
      return GetComponentsWithDependencies(
        getComponents: _getGetComponents(),
        getDependencies: _getGetDependencies(),
      );
    });
  }

  GetComponents _getGetComponents() {
    return GetComponents(
      fileSystemRepository: _getFileSystemRepository(),
      getComponentByFile: _getGetComponentByFile(),
      getComponentTypes: _getGetComponentTypes(),
      getAnalysisConfig: _getGetAnalysisConfig(),
    );
  }

  GetComponentByFile _getGetComponentByFile() {
    return GetComponentByFile(
      getComponentByRelativePath: _getGetComponentByRelativePath(),
    );
  }

  GetComponentByRelativePath _getGetComponentByRelativePath() {
    return GetComponentByRelativePath();
  }

  GetComponentTypes _getGetComponentTypes() {
    return GetComponentTypes(
      fileSystemRepository: _getFileSystemRepository(),
      getAnalysisConfig: _getGetAnalysisConfig(),
    );
  }

  GetDependencies _getGetDependencies() {
    return GetDependencies(
      getDependenciesByFile: _getGetDependenciesByFile(),
      getComponentTypes: _getGetComponentTypes(),
    );
  }

  GetDependenciesByFile _getGetDependenciesByFile() {
    return GetDependenciesByFile(
      getComponentByImport: _getGetComponentByImport(),
      fileSystemRepository: _getFileSystemRepository(),
    );
  }

  GetComponentByImport _getGetComponentByImport() {
    return GetComponentByImport(
      getComponentByRelativePath: _getGetComponentByRelativePath(),
      getAnalysisConfig: _getGetAnalysisConfig(),
    );
  }

  FileSystemRepositoryImpl _getFileSystemRepository() {
    return FileSystemRepositoryImpl(
      debugMode: debugMode,
      fileSystemDataSource: _getFileSystemDataSource(),
    );
  }

  GetAnalysisConfig _getGetAnalysisConfig() {
    return GetAnalysisConfig(
      analysisConfigRepository: _getAnalysisConfigRepository(),
    );
  }

  AnalysisConfigRepository _getAnalysisConfigRepository() {
    return AnalysisConfigRepositoryImpl(
      analysisConfigLocalDataSource: _getAnalysisConfigLocalDataSource(),
      fileSystemDataSource: _getFileSystemDataSource(),
      debugMode: debugMode,
    );
  }

  FileSystemDataSource _getFileSystemDataSource() => FileSystemDataSourceImpl();

  AnalysisConfigLocalDataSource _getAnalysisConfigLocalDataSource() {
    return AppAnalysisConfigLocalDataSource(
      analysisConfigFilePath: analysisConfigFilePath,
    );
  }
}
