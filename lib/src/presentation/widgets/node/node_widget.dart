import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  final String text;

  const NodeWidget({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text(text),
      ),
    );
  }
}
