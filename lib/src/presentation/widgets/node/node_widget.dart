import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/node_state.dart';
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  static const double width = 150;
  final NodeState state;
  final VoidCallback? onTap;
  final String text;
  final bool? selected;
  final Color backgroundColor;

  const NodeWidget({
    required this.text,
    required this.state,
    required this.backgroundColor,
    this.onTap,
    this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _buildGestureDetector(
      child: _buildBackground(
        child: _buildText(context),
      ),
    );
  }

  Widget _buildGestureDetector({required Widget child}) {
    return InkWell(
      onTap: onTap,
      child: child,
    );
  }

  Widget _buildBackground({required Widget child}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _getBorderColor().withOpacity(_getBackgroundOpacity()),
          width: 2,
        ),
        color: backgroundColor.withOpacity(_getBackgroundOpacity()),
      ),
      child: child,
    );
  }

  Color _getBorderColor() {
    return switch (state) {
      NodeState.warning => Colors.yellow,
      NodeState.error => Colors.red[400]!,
      _ => Colors.transparent,
    };
  }

  double _getBackgroundOpacity() {
    if (selected != false) return 1;
    return 0.3;
  }

  Widget _buildText(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.center,
    );
  }
}
