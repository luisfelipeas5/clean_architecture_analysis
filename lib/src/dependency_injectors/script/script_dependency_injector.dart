import 'package:clean_architecture_analysis/src/presentation/csv_exporters/csv_exporter.dart';
import 'package:clean_architecture_analysis/src/presentation/json_exporters/dependencies_json_exporter.dart';
import 'package:clean_architecture_analysis/src/presentation/printers/components_dependencies_printer.dart';
import 'package:clean_architecture_analysis/src/presentation/printers/components_printer.dart';

abstract interface class ScriptDependencyInjector {
  ComponentsPrinter getComponentsPrinter();

  ComponentsDependenciesPrinter getDependenciesPrinter();

  CsvExporter getCsvExporter();

  DependenciesJsonExporter getDependenciesJsonExporter();
}
