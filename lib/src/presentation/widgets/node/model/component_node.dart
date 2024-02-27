import 'package:clean_architecture_analysis/src/domain/entities/components/component.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/node_state.dart';
import 'package:graphview/GraphView.dart';

class ComponentNode extends Node {
  final ComponentWithDependencies componentWithDependencies;

  ComponentNode({
    required this.componentWithDependencies,
    this.state = NodeState.normal,
  }) : super.Id(componentWithDependencies);

  NodeState state;
  
  Component get component {
    return componentWithDependencies.component;
  }

  List<ComponentDependency> get dependencies {
    return componentWithDependencies.dependencies;
  }

  int? get order {
    return componentWithDependencies.component.type?.order;
  }
}

extension NodeExtension on Iterable<ComponentNode> {
  ComponentNode? getDependencyNode(ComponentDependency dependency) {
    for (var node in this) {
      final componentNode = node.component;
      if (componentNode.name == dependency.component.name) {
        return node;
      }
    }
    return null;
  }
}
