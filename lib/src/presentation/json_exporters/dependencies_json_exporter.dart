import 'dart:convert';
import 'dart:io';

import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';

class DependenciesJsonExporter {
  final GetComponentsWithDependencies getComponentsWithDependencies;

  DependenciesJsonExporter({
    required this.getComponentsWithDependencies,
  });

  Future<void> call() async {
    final result = await getComponentsWithDependencies();
    if (result.isFail()) return print("❌ Failed to get dependencies.");

    final file = File("assets/outputs/json/dependencies_output.json");

    final fileContent = _getFileContent(result.data ?? []);
    if (await file.exists()) await file.delete();
    await file.create(recursive: true);

    await file.writeAsString(fileContent);
  }

  String _getFileContent(
    List<ComponentWithDependencies> componentWithDependenciesList,
  ) {
    final json = {
      "components": componentWithDependenciesList.map(_toJson).toList(),
    };

    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }

  Map<String, dynamic> _toJson(
    ComponentWithDependencies componentWithDependencies,
  ) {
    return {
      ...componentWithDependencies.component.toJson(),
      "dependencies": componentWithDependencies.dependencies
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    };
  }
}

extension _ComponentDependencyExtension on ComponentDependency {
  Map<String, dynamic> toJson() {
    return {
      ...component.toJson(),
    };
  }
}

extension _ComponentExtension on Component {
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "type": type?.name,
    };
  }
}
