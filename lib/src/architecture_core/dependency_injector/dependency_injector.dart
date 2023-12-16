import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/file_system/file_system_data_source_impl.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/analysis_config_local_data_source.dart';
import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/analysis_config_local_data_source_impl.dart';
import 'package:clean_architecture_analysis/src/data/repositories/analysis_config/analysis_config_repository_impl.dart';
import 'package:clean_architecture_analysis/src/data/repositories/file_system/file_system_repository_impl.dart';
import 'package:clean_architecture_analysis/src/domain/repositories/analysis_config/analysis_config_repository.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_analysis_config/get_analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_file.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_types.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components_and_types.dart';
import 'package:clean_architecture_analysis/src/presentation/analysis_printer/analysis_printer.dart';
import 'package:clean_architecture_analysis/src/presentation/csv_exporters/components_csv_exporter.dart';
import 'package:clean_architecture_analysis/src/presentation/csv_exporters/csv_exporter.dart';
import 'package:clean_architecture_analysis/src/presentation/printers/components_printer.dart';

class DependencyInjector {
  final String analysisConfigFilePath;
  final bool debugMode;

  const DependencyInjector({
    required this.analysisConfigFilePath,
    required this.debugMode,
  });

  AnalysisPrinter getAnalysisPrinter() {
    return AnalysisPrinter(
      printers: [
        _getComponentsPrinter(),
      ],
    );
  }

  ComponentsPrinter _getComponentsPrinter() {
    return ComponentsPrinter(
      getComponentsAndTypes: _getComponentsAndTypes(),
    );
  }

  CsvExporter getCsvExporter() {
    return CsvExporter(
      componentsCsvExporter: _getComponentsCsvExporter(),
    );
  }

  ComponentsCsvExporter _getComponentsCsvExporter() {
    return ComponentsCsvExporter(
      getComponents: _getGetComponents(),
    );
  }

  GetComponentsAndTypes _getComponentsAndTypes() {
    return GetComponentsAndTypes(
      getComponents: _getGetComponents(),
      getComponentTypes: _getGetComponentTypes(),
    );
  }

  GetComponents _getGetComponents() {
    return GetComponents(
      fileSystemRepository: _getFileSystemRepository(),
      getComponentByFile: GetComponentByFile(),
      getComponentTypes: _getGetComponentTypes(),
      getAnalysisConfig: _getGetAnalysisConfig(),
    );
  }

  GetComponentTypes _getGetComponentTypes() {
    return GetComponentTypes(
      fileSystemRepository: _getFileSystemRepository(),
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
    return AnalysisConfigLocalDataSourceImpl(
      analysisConfigFilePath: analysisConfigFilePath,
    );
  }
}
