import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';
import 'package:clean_architecture_analysis/src/domain/use_cases/get_components/get_component_by_relative_path.dart';

class GetComponentByFile {
  final GetComponentByRelativePath getComponentByRelativePath;

  GetComponentByFile({
    required this.getComponentByRelativePath,
  });

  Future<Result<Component>> call({
    required AppFile file,
    required List<ComponentType> types,
  }) async {
    final componentResult = await getComponentByRelativePath(
      relativePath: file.relativePath,
      types: types,
    );
    if (componentResult.isFail()) return componentResult;

    final component = componentResult.data!;
    component.appFiles.add(file);

    return Result.success(component);
  }

}
