import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';
import 'package:equatable/equatable.dart';

class Component extends Equatable {
  final String name;
  final ComponentType? type;
  final List<AppFile> appFiles;

  const Component({
    required this.name,
    required this.type,
    required this.appFiles,
  });

  @override
  List<Object?> get props => [
        name,
        type,
      ];
}
