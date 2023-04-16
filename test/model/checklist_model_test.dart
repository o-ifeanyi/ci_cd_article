import 'package:checklist_app/model/checklist.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixture/checklist_fixtures.dart';

void main() {
  late ChecklistModel checklistModel;

  setUp(() {
    checklistModel = checkListModelFixture;
  });

  group('ChecklistModel - CopyWith', () {
    test('should return an updated entity when run', () {
      ChecklistModel model = checklistModel;

      expect(model.title, equals('title'));

      model = model.copyWith(title: 'new title');

      expect(model.title, equals('new title'));
    });
  });

  group('ChecklistModel - fromJson/toMap', () {
    test('should return a valid model from map', () {
      final model = ChecklistModel.fromJson(checkListDataFixture);

      expect(model.id, equals(checklistModel.id));
      expect(model.title, equals(checklistModel.title));
    });

    test('should return a valid map from model', () {
      final result = checklistModel.toMap();

      expect(result, equals(checkListDataFixture));
    });
  });
}
