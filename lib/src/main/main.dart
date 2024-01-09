import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/dependency_injector.dart';

enum MainCommand {
  print,
  printDependencies,
  exportCsv,
  exportDependenciesJson,
}

class MainComponent {
  late DependencyInjector injector;

  Future<void> call({
    required String analysisConfigFilePath,
    required MainCommand command,
    required bool debugMode,
  }) async {
    injector = DependencyInjector(
      analysisConfigFilePath: analysisConfigFilePath,
      debugMode: debugMode,
    );

    switch (command) {
      case MainCommand.print:
        return _printComponents();

      case MainCommand.exportCsv:
        return _exportCsv();

      case MainCommand.printDependencies:
        return _printDependencies();

      case MainCommand.exportDependenciesJson:
        return _exportDependenciesJson();
    }
  }

  Future<void> _printComponents() async {
    final componentsPrinter = injector.getComponentsPrinter();
    await componentsPrinter();
  }

  Future<void> _exportCsv() async {
    final csvExporter = injector.getCsvExporter();
    await csvExporter();
  }

  Future<void> _printDependencies() async {
    final dependenciesPrinter = injector.getDependenciesPrinter();
    await dependenciesPrinter();
  }

  Future<void> _exportDependenciesJson() async {
    final dependenciesJsonExporter = injector.getDependenciesJsonExporter();
    await dependenciesJsonExporter();
  }
}
