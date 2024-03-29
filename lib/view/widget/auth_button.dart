import 'package:checklist_app/core/util/config.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.text,
    this.height,
    this.onpressed,
    this.isTransparent = false,
    this.showBorder = true,
    this.hPadding = 20,
  }) : super(key: key);

  final void Function()? onpressed;
  final double? height;
  final String text;
  final bool isTransparent;
  final bool showBorder;
  final double hPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        margin: Config.contentPadding(h: hPadding),
        height: Config.y(height ?? 50),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: isTransparent && showBorder
                ? Border.all(
                    color: theme.colorScheme.secondary,
                  )
                : null,
            color: isTransparent
                ? theme.scaffoldBackgroundColor
                : onpressed == null
                    ? theme.colorScheme.background
                    : theme.primaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          text,
          style: Config.textTheme.bodyMedium?.copyWith(
            color: isTransparent
                ? theme.primaryColor
                : theme.scaffoldBackgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
