import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  static const double width = 150;
  final VoidCallback? onTap;
  final String text;

  const NodeWidget({
    required this.text,
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
        boxShadow: [
          BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
        ],
      ),
      child: child,
    );
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
