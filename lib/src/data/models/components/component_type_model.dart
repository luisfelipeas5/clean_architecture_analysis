import 'package:clean_architecture_analysis/src/data/models/components/component_type_pattern_model.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';

class ComponentTypeModel extends ComponentType {
  const ComponentTypeModel._({
    required super.name,
    required super.patterns,
    required super.order,
  });

  static List<ComponentTypeModel> fromJsonList(
    List<Map<String, dynamic>> jsonList,
  ) {
    return jsonList.map(ComponentTypeModel.fromJson).toList();
  }

  factory ComponentTypeModel.fromJson(Map<String, dynamic> json) {
    return ComponentTypeModel._(
      name: json["name"],
      order: json["order"],
      patterns: ComponentTypePatternModel.fromJsonList(
        (json["patterns"] as List<dynamic>).cast(),
      ),
    );
  }
}
