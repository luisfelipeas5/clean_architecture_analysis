import 'dart:ui';

import 'package:graphview/GraphView.dart';

class CustomAlgorithm extends Algorithm {
  CustomAlgorithm({
    required EdgeRenderer renderer,
  }) {
    this.renderer = renderer;
  }

  @override
  void init(Graph? graph) {}

  @override
  Size run(Graph? graph, double shiftX, double shiftY) {
    return getMaxSize(graph);
  }

  Size getMaxSize(Graph? graph) {
    double maxX = 0;
    double maxY = 0;
    for (var node in graph?.nodes ?? <Node>[]) {
      if (node.x > maxX) {
        maxX = node.x;
      }
      if (node.y > maxY) {
        maxY = node.y;
      }
    }
    return Size(maxX, maxY);
  }

  @override
  void setDimensions(double width, double height) {}

  @override
  void setFocusedNode(Node node) {}

  @override
  void step(Graph? graph) {}
}
