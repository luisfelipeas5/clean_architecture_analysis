import 'package:clean_architecture_analysis/src/presentation/widgets/node/model/node_state.dart';
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  static const double width = 150;
  final NodeState state;
  final VoidCallback? onTap;
  final String text;

  const NodeWidget({
    required this.text,
    required this.state,
    this.onTap,
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
        color: _getBackgroundColor(),
      ),
      child: child,
    );
  }

  Color? _getBackgroundColor() {
    return switch (state) {
      NodeState.warning => Colors.yellow,
      NodeState.error => Colors.red[400],
      _ => Colors.blue[100],
    };
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
