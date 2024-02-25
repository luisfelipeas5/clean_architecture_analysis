import 'dart:math';
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
    var left = double.infinity;
    var top = double.infinity;
    var right = double.negativeInfinity;
    var bottom = double.negativeInfinity;

    for (var node in graph?.nodes ?? <Node>[]) {
      left = min(left, node.x - node.width);
      top = min(top, node.y - node.height);
      right = max(right, node.x + node.width);
      bottom = max(bottom, node.y + node.height);
    }

    return Size(right - left, bottom - top);
  }

  @override
  void setDimensions(double width, double height) {}

  @override
  void setFocusedNode(Node node) {}

  @override
  void step(Graph? graph) {}
}
