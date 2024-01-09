import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:equatable/equatable.dart';

class ComponentDependency extends Equatable {
  final Component component;

  const ComponentDependency({
    required this.component,
  });

  @override
  List<Object?> get props => [
        component,
      ];
}
