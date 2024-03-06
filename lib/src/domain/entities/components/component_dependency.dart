import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';
import 'package:equatable/equatable.dart';

class ComponentDependency extends Equatable {
  final Component component;
  final bool wrongOrder;
  final List<AppFile> importedFiles;

  const ComponentDependency({
    required this.component,
    required this.wrongOrder,
    required this.importedFiles,
  });

  @override
  List<Object?> get props => [
        component,
        wrongOrder,
      ];

  ComponentDependency copyWithAdditionalFiles({
    required List<AppFile> additionalImportedFiles,
  }) {
    return ComponentDependency(
      component: component,
      wrongOrder: wrongOrder,
      importedFiles: importedFiles..addAll(additionalImportedFiles),
    );
  }
}
