import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_relative_path.dart';

class GetComponentByImport {
  final GetComponentByRelativePath getComponentByRelativePath;

  GetComponentByImport({
    required this.getComponentByRelativePath,
  });

  Result<Component> call({
    required String import,
    required List<ComponentType> types,
  }) {
    final relativePath = _getRelativePath(import);
    final componentResult = getComponentByRelativePath(
      relativePath: relativePath,
      types: types,
    );
    if (componentResult.isFail()) return componentResult;

    final component = componentResult.data!;
    return Result.success(component);
  }

  String _getRelativePath(String import) {
    final relativePathRegex = RegExp(".*:(.*)");
    final match = relativePathRegex.firstMatch(import);
    return match?.group(1) ?? "";
  }
}
