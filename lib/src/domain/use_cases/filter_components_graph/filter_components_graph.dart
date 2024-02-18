import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';

class FilterComponentsGraph {
  Result<List<ComponentWithDependencies>> call({
    required List<ComponentWithDependencies> components,
  }) {
    final filteredComponents = components.where(_filterNodes).toList();
    return Result.success(filteredComponents);
  }

  bool _filterNodes(ComponentWithDependencies componentWithDependencies) {
    final component = componentWithDependencies.component;
    final order = component.type?.order;
    if (order == null) return false;

    final name = component.name;
    if (name.contains("feature_core/")) return false;

    return true;
  }
}
