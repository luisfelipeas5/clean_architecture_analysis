import 'package:clean_architecture_analysis/src/presentation/printers/printer.dart';

class AnalysisPrinter {
  final List<Printer> printers;

  const AnalysisPrinter({
    required this.printers,
  });

  Future<void> call() async {
    print("\nClean Architecture Analysis: ");
    for (var printer in printers) {
      await printer();
    }
  }
}
