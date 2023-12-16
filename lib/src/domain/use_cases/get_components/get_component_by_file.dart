import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';

class GetComponentByFile {
  Result<Component> call({
    required AppFile file,
    required List<ComponentType> types,
  }) {
    final type = _getType(file, types);
    final name = _getName(file, type);

    final component = Component(
      name: name,
      type: type,
    );

    return Result.success(component);
  }

  ComponentType? _getType(AppFile file, List<ComponentType> types) {
    for (var type in types) {
      final regex = RegExp(type.pattern);
      if (regex.hasMatch(file.path)) return type;
    }
    return null;
  }

  String _getName(AppFile file, ComponentType? type) {
    final relativePath = file.relativePath;
    if (type == null) return relativePath;

    for (var pattern in type.patterns) {
      final regex = RegExp("($pattern)(.*)");
      final match = regex.firstMatch(relativePath);
      final group = match?.group(1);
      if (group != null) return group;
    }

    return relativePath;
  }
}
