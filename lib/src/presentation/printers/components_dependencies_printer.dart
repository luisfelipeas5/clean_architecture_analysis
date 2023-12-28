import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_dependencies/get_components_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/printers/printer.dart';

final class ComponentsDependenciesPrinter implements Printer {
  final GetComponentsWithDependencies getComponentsWithDependencies;

  const ComponentsDependenciesPrinter({
    required this.getComponentsWithDependencies,
  });

  @override
  Future<void> call() async {
    final result = await getComponentsWithDependencies();
    if (result.isFail()) {
      return print("❌ Failed to get components with dependencies.");
    }

    print("✅ Components with dependencies:");
    final componentsWithDependencies = result.data;
    componentsWithDependencies?.forEach(_printComponentWithDependencies);
  }

  void _printComponentWithDependencies(
    ComponentWithDependencies componentWithDependencies,
  ) {
    _printComponent(componentWithDependencies.component);

    final dependencies = componentWithDependencies.dependencies;
    for (var dependency in dependencies) {
      _printDependency(dependency);
    }
  }

  void _printDependency(ComponentDependency dependency) {
    _printComponent(
      dependency.component,
      prefix: "        ",
    );
  }

  void _printComponent(
    Component component, {
    String prefix = "",
  }) {
    final Component(:name, :type) = component;
    final typeName = type?.name ?? "unknown";
    print("$prefix|- Component $name ($typeName)");
  }
}
