part of '../component_graph_controller.dart';

void selectComponent({
  required Graph graph,
  required ComponentNode componentNodeSelected,
}) {
  if (componentNodeSelected.selected == true) return;

  componentNodeSelected.selected = true;

  for (var node in graph.nodes) {
    final possibleDependencyNode = node as ComponentNode;
    if (_isDependency(
      dependencies: componentNodeSelected.dependencies,
      componentNode: possibleDependencyNode,
    )) {
      selectComponent(
        graph: graph,
        componentNodeSelected: possibleDependencyNode,
      );
    }
  }
}

bool _isDependency({
  required List<ComponentDependency> dependencies,
  required ComponentNode componentNode,
}) {
  return dependencies.any((dependency) {
    return dependency.component.name == componentNode.component.name;
  });
}
