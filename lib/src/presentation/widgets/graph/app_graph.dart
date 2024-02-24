import 'dart:math';

import 'package:clean_architecture_analysis/src/presentation/widgets/graph/algorithm/custom_algorithm.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class AppGraph extends StatelessWidget {
  const AppGraph({
    required this.graph,
    required this.nodeWidgetBuilder,
    super.key,
  });

  final Graph graph;
  final NodeWidgetBuilder nodeWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final customAlgorithm = CustomAlgorithm(
      renderer: ArrowEdgeRenderer(),
    );
    final maxSize = customAlgorithm.getMaxSize(graph);
    return InteractiveViewer(
      constrained: false,
      boundaryMargin: EdgeInsets.all(min(maxSize.height, maxSize.width)),
      minScale: 0.01,
      maxScale: 5.6,
      child: GraphView(
        graph: graph,
        algorithm: customAlgorithm,
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: nodeWidgetBuilder,
      ),
    );
  }
}
