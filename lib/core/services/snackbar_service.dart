import 'dart:async';

import 'package:overlay_support/overlay_support.dart';

enum DisplayType { snackbar, dialog }

enum Status { success, failed }

class SnackbarModel {
  final String? title;
  final String message;
  final NotificationPosition position;
  final SnackbarAction? action;
  final Duration duration;
  final DisplayType displayType;
  final Status status;

  SnackbarModel({
    required this.title,
    required this.message,
    this.position = NotificationPosition.top,
    this.duration = const Duration(seconds: 4),
    this.action,
    this.displayType = DisplayType.snackbar,
    this.status = Status.failed,
  });
}

class SnackbarAction {
  final String text;
  final void Function() onPressed;

  SnackbarAction({required this.text, required this.onPressed});
}

class SnackBarService {
  static final SnackBarService _snackBarService = SnackBarService._internal();
  factory SnackBarService() {
    return _snackBarService;
  }
  SnackBarService._internal();

  final StreamController<SnackbarModel> _controller =
      StreamController<SnackbarModel>();

  Stream<SnackbarModel> get stream => _controller.stream;
  StreamController<SnackbarModel> get controller => _controller;

  displayMessage(String message,
      {Status status = Status.failed, String? title}) {
    controller.add(SnackbarModel(
      title: title,
      message: message,
      status: status,
    ));
  }

  displayDialog(
      {required String title,
      required String message,
      SnackbarAction? action,
      Status status = Status.failed}) {
    controller.add(SnackbarModel(
        title: title,
        message: message,
        status: status,
        action: action,
        displayType: DisplayType.dialog));
  }

  void dispose() => _controller.close();
}
