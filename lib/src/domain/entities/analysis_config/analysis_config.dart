import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';

class AnalysisConfig {
  final String path;
  final String packageName;
  final List<String> exclude;
  final List<ComponentType> componentTypes;

  const AnalysisConfig({
    required this.path,
    required this.packageName,
    required this.exclude,
    required this.componentTypes,
  });
}
