import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';

class GetComponentByRelativePath {
  Result<Component> call({
    required String relativePath,
    required List<ComponentType> types,
  }) {
    final type = _getType(relativePath, types);
    final name = _getName(relativePath, type);

    final component = Component(
      name: name,
      type: type,
      appFiles: [],
    );

    return Result.success(component);
  }

  ComponentType? _getType(String relativePath, List<ComponentType> types) {
    for (var type in types) {
      for (var pattern in type.patterns) {
        final regex = pattern.regex;
        if (regex.hasMatch(relativePath)) return type;
      }
    }
    return null;
  }

  String _getName(String relativePath, ComponentType? type) {
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
