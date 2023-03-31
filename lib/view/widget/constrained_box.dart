import 'package:flutter/material.dart';

class ConstrainedBoxWidget extends StatelessWidget {
  final double width;
  final Widget child;
  const ConstrainedBoxWidget({Key? key, required this.child, this.width = 1200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: width),
        child: child,
      ),
    );
  }
}
