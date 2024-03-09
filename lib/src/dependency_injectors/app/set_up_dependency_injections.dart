import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/app/app_dependency_injector.dart';
import 'package:clean_architecture_analysis/src/dependency_injectors/app/data/set_up_data_sources_dependency_injections.dart';
import 'package:clean_architecture_analysis/src/dependency_injectors/app/data/set_up_repositories_dependency_injections.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/filter_components_graph/filter_components_graph.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_analysis_config/get_analysis_config.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_file.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_import.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_relative_path.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_types.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_dependencies_by_file.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_order_circuferences/get_order_circuferences.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/set_components_graph_node_positions/set_components_graph_node_positions.dart';

class SetUpDependencyInjections {
  final AppDependencyInjector injector;
  final bool debugMode;
  final String analysisConfigFilePath;

  SetUpDependencyInjections({
    required this.injector,
    required this.analysisConfigFilePath,
    required this.debugMode,
  });

  void call() {
    SetUpDataSourcesDependencyInjections(
      injector: injector,
      analysisConfigFilePath: analysisConfigFilePath,
    )();

    SetUpRepositoriesDependencyInjections(
      injector: injector,
      debugMode: debugMode,
    )();

    _putUseCasesDirectWithRepository();

    injector.putSingleton<GetComponentTypes>((injector) {
      return GetComponentTypes(
        fileSystemRepository: injector(),
        getAnalysisConfig: injector(),
      );
    });
    

    injector.putSingleton<GetComponentByRelativePath>((injector) {
      return GetComponentByRelativePath(
        fileSystemRepository: injector(),
        getAnalysisConfig: injector(),
      );
    });

    injector.putSingleton<GetComponentByImport>((injector) {
      return GetComponentByImport(
        getAnalysisConfig: injector(),
        getComponentByRelativePath: injector(),
      );
    });

    injector.putSingleton<GetDependenciesByFile>((injector) {
      return GetDependenciesByFile(
        fileSystemRepository: injector(),
        getComponentByImport: injector(),
      );
    });

    injector.putSingleton<GetComponentByFile>((injector) {
      return GetComponentByFile(
        getComponentByRelativePath: injector(),
      );
    });

    injector.putSingleton<GetComponents>((injector) {
      return GetComponents(
        getComponentByFile: injector(),
        getComponentTypes: injector(),
        fileSystemRepository: injector(),
        getAnalysisConfig: injector(),
      );
    });

    injector.putSingleton<GetDependencies>((injector) {
      return GetDependencies(
        getDependenciesByFile: injector(),
        getComponentTypes: injector(),
      );
    });

    injector.putSingleton<GetComponentsWithDependencies>((injector) {
      return GetComponentsWithDependencies(
        getComponents: injector(),
        getDependencies: injector(),
      );
    });

    injector.putSingleton((injector) {
      return SetComponentsGraphNodePositions(
        getOrderCircuferences: injector(),
      );
    });
  }
  
  void _putUseCasesDirectWithRepository() {
    injector.putSingleton<GetAnalysisConfig>((injector) {
      return GetAnalysisConfig(
        analysisConfigRepository: injector(),
      );
    });
    
    injector.putSingleton((injector) {
      return GetOrderCircuferences();
    });

    injector.putSingleton((injector) {
      return FilterComponentsGraph();
    });
  }
}
