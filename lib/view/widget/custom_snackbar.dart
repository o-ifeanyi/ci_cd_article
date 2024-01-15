import 'package:checklist_app/core/services/snackbar_service.dart';
import 'package:checklist_app/core/util/config.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final SnackbarModel snackbarModel;
  final void Function() onDismiss;

  const CustomSnackBar({
    Key? key,
    required this.snackbarModel,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTapDown: (_) => onDismiss(),
        child: Container(
          padding: Config.contentPadding(h: 20, v: 10),
          width: size.width,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(5)),
            color: snackbarModel.status == Status.success
                ? Colors.greenAccent
                : Theme.of(context).colorScheme.error,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (snackbarModel.title != null)
                  Text(
                    snackbarModel.title!,
                    style: Config.textTheme.bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                Text(
                  snackbarModel.message,
                  style: Config.textTheme.bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
