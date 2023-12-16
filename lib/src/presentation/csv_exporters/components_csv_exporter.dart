import 'dart:io';

import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components.dart';

class ComponentsCsvExporter {
  final GetComponents getComponents;

  ComponentsCsvExporter({
    required this.getComponents,
  });

  Future<void> call() async {
    final result = await getComponents();
    if (result.isFail()) return print("❌ Failed to get components.");

    final file = File("assets/outputs/csv/components_output.csv");

    final fileContent = _getFileContent(result.data ?? []);
    if (await file.exists()) await file.delete();
    await file.create(recursive: true);

    await file.writeAsString(fileContent);
  }

  String _getFileContent(List<Component> components) {
    final headers = "name,type";
    final tuples = components.map(_getTuple).join("\n");
    return "$headers\n$tuples";
  }

  String _getTuple(Component component) {
    final Component(name: name, type: type) = (component);
    return "$name,${type!.name}";
  }
}
