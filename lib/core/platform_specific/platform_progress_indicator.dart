import 'package:checklist_app/core/util/config.dart';
import 'package:flutter/material.dart';

class PlatformProgressIndicator extends StatelessWidget {
  const PlatformProgressIndicator({Key? key, this.height}) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Config.y(height ?? 30),
      width: Config.y(height ?? 30),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
