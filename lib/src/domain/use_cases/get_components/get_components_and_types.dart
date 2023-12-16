import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_types.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_components.dart';

class GetComponentsAndTypes {
  final GetComponents getComponents;
  final GetComponentTypes getComponentTypes;

  GetComponentsAndTypes({
    required this.getComponents,
    required this.getComponentTypes,
  });

  Future<Result<ComponentsAndTypes>> call() async {
    final componentsResult = await getComponents();
    if (componentsResult.isFail()) return componentsResult.parseFail();

    final typesResult = await getComponentTypes();
    if (typesResult.isFail()) return typesResult.parseFail();

    final componentsAndTypes = ComponentsAndTypes(
      components: componentsResult.data!,
      types: typesResult.data!,
    );
    return Result.success(componentsAndTypes);
  }
}

class ComponentsAndTypes {
  final List<Component> components;
  final List<ComponentType> types;

  ComponentsAndTypes({
    required this.components,
    required this.types,
  });
}
