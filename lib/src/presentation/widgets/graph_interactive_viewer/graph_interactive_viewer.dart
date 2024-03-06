import 'dart:math';

import 'package:clean_architecture_analysis/src/presentation/widgets/graph/algorithm/custom_algorithm.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class GraphInteractiveViewer extends StatelessWidget {
  final Graph graph;
  final CustomAlgorithm customAlgorithm;
  final Widget child;

  const GraphInteractiveViewer({
    required this.graph,
    required this.customAlgorithm,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final maxSize = customAlgorithm.getMaxSize(graph);
    return InteractiveViewer(
      constrained: false,
      boundaryMargin: EdgeInsets.all(min(maxSize.height, maxSize.width)),
      minScale: 0.01,
      maxScale: 5.6,
      alignment: Alignment.center,
      child: child,
    );
  }
}
