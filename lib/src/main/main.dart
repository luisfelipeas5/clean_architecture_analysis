import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/dependency_injector.dart';

enum MainCommand {
  print,
  exportCsv,
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
        return _print();

      case MainCommand.exportCsv:
        return _exportCsv();
    }
  }

  Future<void> _print() async {
    final analysisPrinter = injector.getAnalysisPrinter();
    await analysisPrinter();
  }

  Future<void> _exportCsv() async {
    final csvExporter = injector.getCsvExporter();
    await csvExporter();
  }
}
