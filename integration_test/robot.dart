import 'dart:async';

import 'package:checklist_app/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:checklist_app/main.dart' as app;

class Robot {
  final WidgetTester tester;

  Robot(this.tester);

  Future<void> startApp() async {
    await app.main();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 50));
  }

  Future<void> waitFor(
    Finder finder, {
    Matcher? matcher,
    int timeOutSeconds = 10,
    int interval = 500,
  }) async {
    Completer c = Completer();
    late Timer checker;
    late Timer timeOut;
    checker = Timer.periodic(Duration(milliseconds: interval), (_) async {
      await tester.pump();
      if (finder.evaluate().isNotEmpty && matcher == null) {
        checker.cancel();
        timeOut.cancel();
        c.complete();
      } else if (finder.evaluate().isNotEmpty &&
          matcher != null &&
          matcher.matches(finder, {})) {
        checker.cancel();
        timeOut.cancel();
        c.complete();
      }
    });

    timeOut = Timer.periodic(Duration(seconds: timeOutSeconds), (_) {
      if (!c.isCompleted) {
        checker.cancel();
        c.completeError('WaitFor timed out for ${finder.description}');
      }
    });

    return c.future;
  }

  Future<void> tap(Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 50));
  }

  Future<void> tapAt(Finder finder, {double? x, double? y}) async {
    final center = tester.getCenter(finder);
    await tester.tapAt(Offset(x ?? center.dx, y ?? center.dy));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 50));
  }

  Future<void> longPress(Finder finder) async {
    await tester.longPress(finder);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 50));
  }

  Future<void> enterText(Finder finder, String text) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 50));
  }

  Future<void> destroy() async {
    await sl.reset();
  }
}
