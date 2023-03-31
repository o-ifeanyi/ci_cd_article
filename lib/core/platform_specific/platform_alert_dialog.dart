import 'package:checklist_app/core/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogAction {
  final String text;
  final void Function() onPressed;
  final bool isDefaultAction;

  DialogAction({
    required this.text,
    required this.onPressed,
    this.isDefaultAction = false,
  });
}

class PlatformAlertDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final List<DialogAction> actions;

  const PlatformAlertDialog(
      {Key? key, this.title, required this.content, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Config.isAndroid
        ? AlertDialog(
            title:
                title != null ? Text(title!, style: Config.h3b(context)) : null,
            content: content,
            actions: actions
                .map(
                  (e) => TextButton(
                      onPressed: e.onPressed,
                      child: Text(
                        e.text,
                        style: Config.b1(context),
                      )),
                )
                .toList(),
          )
        : CupertinoAlertDialog(
            title:
                title != null ? Text(title!, style: Config.h3b(context)) : null,
            content: content,
            actions: actions
                .map(
                  (e) => CupertinoDialogAction(
                      isDefaultAction: e.isDefaultAction,
                      onPressed: e.onPressed,
                      child: Text(
                        e.text,
                        style: Config.b1(context),
                      )),
                )
                .toList(),
          );
  }
}
