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
    return InteractiveViewer(
      constrained: false,
      boundaryMargin: EdgeInsets.all(100),
      minScale: 0.01,
      maxScale: 5.6,
      child: GraphView(
        graph: graph,
        algorithm: CustomAlgorithm(),
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: nodeWidgetBuilder,
      ),
    );
  }
}
