import 'package:checklist_app/core/util/config.dart';
import 'package:flutter/material.dart';

import 'platform_alert_dialog.dart';
import 'platform_progress_indicator.dart';

class DialogLoader<T> extends StatefulWidget {
  final Future<bool?> Function() function;
  const DialogLoader({Key? key, required this.function}) : super(key: key);

  @override
  State<DialogLoader<T>> createState() => _DialogLoaderState<T>();
}

class _DialogLoaderState<T> extends State<DialogLoader<T>> {
  Future<void> call() async {
    final done = await widget.function.call();
    Navigator.pop(context, done);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      content: Padding(
        padding: Config.contentPadding(context, v: 3),
        child: const PlatformProgressIndicator(),
      ),
      actions: [],
    );
  }
}
