import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:equatable/equatable.dart';

class ComponentDependency extends Equatable {
  final Component component;
  final bool wrongOrder;

  const ComponentDependency({
    required this.component,
    required this.wrongOrder,
  });

  @override
  List<Object?> get props => [
        component,
        wrongOrder,
      ];
}
