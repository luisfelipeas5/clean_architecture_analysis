import 'package:clean_architecture_analysis/src/presentation/csv_exporters/components_csv_exporter.dart';

class CsvExporter {
  final ComponentsCsvExporter componentsCsvExporter;

  CsvExporter({
    required this.componentsCsvExporter,
  });

  Future<void> call() async {
    await componentsCsvExporter();
  }
}
