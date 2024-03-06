import 'package:clean_architecture_analysis/src/presentation/widgets/graph/algorithm/custom_algorithm.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class AppGraphWidget extends StatelessWidget {
  const AppGraphWidget({
    required this.customAlgorithm,
    required this.graph,
    required this.nodeWidgetBuilder,
    super.key,
  });

  final Graph graph;
  final NodeWidgetBuilder nodeWidgetBuilder;
  final CustomAlgorithm customAlgorithm;

  @override
  Widget build(BuildContext context) {
    return GraphView(
      graph: graph,
      algorithm: customAlgorithm,
      paint: _getDefaultPaint(),
      builder: nodeWidgetBuilder,
    );
  }

  Paint _getDefaultPaint() {
    return Paint()
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
  }
}
