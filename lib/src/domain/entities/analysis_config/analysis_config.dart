import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';

class AnalysisConfig {
  final String path;
  final List<String> exclude;
  final List<ComponentType> componentTypes;

  const AnalysisConfig({
    required this.path,
    required this.exclude,
    required this.componentTypes,
  });
}
