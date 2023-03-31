import 'package:checklist_app/view/widget/checklist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'keys.dart';
import 'robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App test', () {
    testWidgets('App flow', (WidgetTester tester) async {
      final robot = Robot(tester);

      await robot.startApp();

      // Create checklist
      await robot.waitFor(find.byKey(Keys.addBtn), matcher: findsOneWidget);
      await robot.tap(find.byKey(Keys.addBtn));
      expect(find.text('title'), findsOneWidget);
      await robot.enterText(find.byKey(Keys.titleField), 'Test');
      await robot.enterText(find.byType(TextFormField).last, 'First task');
      await robot.tap(find.byKey(Keys.addNewItemBtn));
      await robot.enterText(find.byType(TextFormField).last, 'Second task');
      await robot.tap(find.byKey(Keys.addNewItemBtn));
      await robot.enterText(find.byType(TextFormField).last, 'Third task');
      await robot.tap(find.byType(BackButton));
      expect(find.byType(ChecklistItem), findsNWidgets(1));

      // Update checklist
      await robot.tap(find.byType(ChecklistItem).first);
      expect(find.text('First task'), findsOneWidget);
      expect(find.text('Second task'), findsOneWidget);
      expect(find.text('Third task'), findsOneWidget);

      expect(find.byType(Divider), findsNothing);
      await robot.tapAt(find.byType(CheckboxListTile).last, x: 35);
      await robot.waitFor(find.byKey(Keys.divider), matcher: findsOneWidget);
      await robot.tap(find.byType(BackButton));

      // Create checklist
      await robot.waitFor(find.byKey(Keys.addBtn), matcher: findsOneWidget);
      await robot.tap(find.byKey(Keys.addBtn));
      expect(find.text('title'), findsOneWidget);
      await robot.enterText(find.byKey(Keys.titleField), 'Search');
      await robot.tap(find.byType(BackButton));
      expect(find.byType(ChecklistItem), findsNWidgets(2));

      // Delete all checklist
      expect(find.text('Select all  (1)'), findsNothing);
      await robot.longPress(find.byType(ChecklistItem).at(0));
      expect(find.text('Select all  (1)'), findsOneWidget);
      await robot.tap(find.byType(ChecklistItem).at(1));
      expect(find.text('Select all  (2)'), findsOneWidget);
      await robot.tap(find.byKey(Keys.deleteBtn));
      expect(find.byType(ChecklistItem), findsNothing);

      await robot.destroy();
    });
  });
}
