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
    final buchheimWalkerConfiguration = getConfiguration();

    return InteractiveViewer(
      constrained: false,
      boundaryMargin: EdgeInsets.all(100),
      minScale: 0.01,
      maxScale: 5.6,
      child: GraphView(
        graph: graph,
        algorithm: BuchheimWalkerAlgorithm(
          buchheimWalkerConfiguration,
          ArrowEdgeRenderer(),
        ),
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: nodeWidgetBuilder,
      ),
    );
  }

  BuchheimWalkerConfiguration getConfiguration() {
    return BuchheimWalkerConfiguration()
      ..levelSeparation = 100
      ..siblingSeparation = 500
      ..subtreeSeparation = 500
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }
}
