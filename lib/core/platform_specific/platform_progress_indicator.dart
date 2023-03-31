import 'package:checklist_app/core/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformProgressIndicator extends StatelessWidget {
  const PlatformProgressIndicator({Key? key, this.height}) : super(key: key);

  final double? height;

  Widget progress() {
    if (kIsWeb) return const CircularProgressIndicator();
    if (Config.isIOS || Config.isMacOS) {
      return const CupertinoActivityIndicator(radius: 15);
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Config.yMargin(context, height ?? 7),
      width: Config.yMargin(context, height ?? 7),
      child: Center(
        child: progress(),
      ),
    );
  }
}
