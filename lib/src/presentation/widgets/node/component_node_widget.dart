import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/component_node.dart';
import 'package:clean_architecture_analysis/src/presentation/widgets/node/node_widget.dart';
import 'package:flutter/material.dart';

typedef OnComponentNodeTap = void Function(
  ComponentNode componentNode,
);

class ComponentNodeWidget extends StatelessWidget {
  final ComponentNode componentNode;
  final OnComponentNodeTap? onTap;

  const ComponentNodeWidget({
    required this.componentNode,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      text: _text,
      state: componentNode.state,
      selected: componentNode.selected,
      backgroundColor: _backgroundColor,
      onTap: () => onTap?.call(componentNode),
    );
  }

  Color get _backgroundColor {
    return switch (componentNode.order) {
      0 => Color(0xffff9feaf),
      1 => Color(0xfffff9d99),
      2 => Color(0xfff83ffb3),
      _ => Color(0xfff9adaff),
    };
  }

  String get _text {
    final name = componentNode.component.name;
    return name
        .replaceFirst("modules/", "")
        .replaceFirst("feature_core/", "f_c/");
  }
}
