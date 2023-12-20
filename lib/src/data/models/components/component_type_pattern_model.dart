import 'package:clean_architecture_analysis/src/domain/entities/components/component_type_pattern.dart';

class ComponentTypePatternModel extends ComponentTypePattern {
  const ComponentTypePatternModel._({
    required super.regex,
    required super.name,
  });

  static List<ComponentTypePatternModel> fromJsonList(
    List<Map<String, dynamic>> jsonList,
  ) {
    return jsonList.map(ComponentTypePatternModel.fromJson).toList();
  }

  factory ComponentTypePatternModel.fromJson(Map<String, dynamic> json) {
    return ComponentTypePatternModel._(
      regex: RegExp(json["regex"]),
      name: json["name"],
    );
  }
}
