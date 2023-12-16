import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';

class ComponentTypeModel extends ComponentType {
  const ComponentTypeModel._({
    required super.name,
    required super.patterns,
  });

  static List<ComponentTypeModel> fromJsonList(
    List<Map<String, dynamic>> jsonList,
  ) {
    return jsonList.map(ComponentTypeModel.fromJson).toList();
  }

  factory ComponentTypeModel.fromJson(Map<String, dynamic> json) {
    return ComponentTypeModel._(
      name: json["name"],
      patterns: (json["patterns"] as List<dynamic>).cast(),
    );
  }
}
