import 'package:clean_architecture_analysis/src/data/models/components/component_type_model.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';

class AnalysisConfigModel extends AnalysisConfig {
  const AnalysisConfigModel._({
    required super.path,
    required super.packageName,
    required super.exclude,
    required super.componentTypes,
  });

  factory AnalysisConfigModel.fromJson(Map<String, dynamic> json) {
    return AnalysisConfigModel._(
      path: json["path"],
      packageName: json["packageName"],
      exclude: (json["exclude"] as List<dynamic>).cast(),
      componentTypes: ComponentTypeModel.fromJsonList(
        (json["componentTypes"] as List<dynamic>).cast(),
      ),
    );
  }
}
