import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/node_widget.dart';
import 'package:flutter/material.dart';

class ComponentNodeWidget extends StatelessWidget {
  final ComponentNode componentNode;

  const ComponentNodeWidget({
    required this.componentNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      text: _text,
    );
  }

  String get _text {
    final name = componentNode.component.name;
    return name
        .replaceFirst("modules/", "")
        .replaceFirst("feature_core/", "f_c/");
  }
}
