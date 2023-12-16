import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components_and_types.dart';
import 'package:clean_architecture_analysis/src/presentation/printers/printer.dart';

final class ComponentsPrinter implements Printer {
  final GetComponentsAndTypes getComponentsAndTypes;

  const ComponentsPrinter({
    required this.getComponentsAndTypes,
  });

  @override
  Future<void> call() async {
    final result = await getComponentsAndTypes();
    if (result.isFail()) return print("❌ Failed to get components.");

    print("✅ Components:");
    final components = result.data?.components;
    final types = result.data?.types ?? [];
    components?.sort((a, b) {
      return _compareByType(types, a, b);
    });
    components?.forEach(_printComponent);
  }

  int _compareByType(List<ComponentType> types, Component a, Component b) {
    if (a.type == null) return 1;
    if (b.type == null) return -1;
    return types.indexOf(a.type!) - types.indexOf(b.type!);
  }

  void _printComponent(Component component) {
    final Component(:name, :type) = component;
    final typeName = type?.name ?? "unknown";
    print("Component $name ($typeName)");
  }
}
