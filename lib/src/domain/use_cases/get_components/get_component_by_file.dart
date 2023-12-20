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
      for (var pattern in type.patterns) {
        final regex = pattern.regex;
        final matchAsPrefix = regex.matchAsPrefix(file.relativePath) != null;
        if (matchAsPrefix) return type;
      }
    }
    return null;
  }

  String _getName(AppFile file, ComponentType? type) {
    final relativePath = file.relativePath;
    if (type == null) return relativePath;

    for (var pattern in type.patterns) {
      final match = pattern.regex.firstMatch(relativePath);
      if (match == null) continue;

      String name = pattern.name;
      for (var groupIndex = 0; groupIndex <= match.groupCount; groupIndex++) {
        final group = match.group(groupIndex)!;
        name = name.replaceAll("\${$groupIndex}", group);
      }
      return name;
    }

    return relativePath;
  }
}
