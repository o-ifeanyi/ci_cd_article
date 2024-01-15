import 'package:checklist_app/core/platform_specific/platform_alert_dialog.dart';
import 'package:checklist_app/core/services/snackbar_service.dart';
import 'package:checklist_app/view/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

class AppAware extends StatefulWidget {
  final Widget child;

  const AppAware({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  _AppAwareState createState() => _AppAwareState();
}

class _AppAwareState extends State<AppAware> {
  OverlaySupportEntry? _snackBarEntry;
  OverlaySupportEntry? _dialogEntry;
  late SnackBarService _snackBarService;
  @override
  void initState() {
    _snackBarService = SnackBarService();
    _snackBarService.stream.listen((event) {
      if (event.displayType == DisplayType.dialog) {
        _dialogEntry?.dismiss();
        _dialogEntry = showOverlay(
          (context, _) {
            return Material(
              color: Colors.black38,
              child: PlatformAlertDialog(
                title: event.title,
                content: Text(event.message),
                actions: [
                  DialogAction(
                    text: 'Close',
                    onPressed: () => _dialogEntry!.dismiss(),
                  ),
                  if (event.action != null)
                    DialogAction(
                      isDefaultAction: true,
                      text: event.action!.text,
                      onPressed: event.action!.onPressed,
                    ),
                ],
              ),
            );
          },
          duration: Duration.zero,
        );
        HapticFeedback.heavyImpact();
      } else {
        _snackBarEntry?.dismiss();
        _snackBarEntry = showOverlayNotification(
          (context) {
            return CustomSnackBar(
              snackbarModel: event,
              onDismiss: _snackBarEntry!.dismiss,
            );
          },
          position: event.position,
          duration: event.duration,
        );
        HapticFeedback.mediumImpact();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: widget.child,
    );
  }
}
