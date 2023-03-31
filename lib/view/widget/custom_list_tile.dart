import 'package:checklist_app/core/util/config.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onPressed,
    this.highlightColor,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final Color? highlightColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onPressed,
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(iconData, size: 20),
      ),
      title: Text(
        title,
        style: Config.b1(context).copyWith(color: highlightColor),
      ),
    );
  }
}
