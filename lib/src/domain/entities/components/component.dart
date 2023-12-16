import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:equatable/equatable.dart';

class Component extends Equatable {
  final String name;
  final ComponentType? type;

  const Component({
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [
        name,
        type,
      ];
}
