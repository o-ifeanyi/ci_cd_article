import 'package:checklist_app/data/checklist_repository.dart';
import 'package:checklist_app/model/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fixture/Checklist_fixtures.dart';
import '../mocks.dart';

void main() {
  late MockHiveService hiveService;
  late ChecklistRepositoryImpl checklistRepositoryImpl;
  late CustomException customException;

  setUp(() {
    hiveService = MockHiveService();
    customException = CustomException(message: 'Failed');
    checklistRepositoryImpl = ChecklistRepositoryImpl(
      hiveService: hiveService,
    );
    registerFallbackValue(checkListModelFixture);
  });

  group('Checklist repository - All', () {
    test('Should return a list of ChecklistModel when successful', () async {
      when(() => hiveService.allChecklist()).thenAnswer(
        (_) => Future.value([]),
      );

      final result = await checklistRepositoryImpl.all();

      expect(result.isRight(), equals(true));
    });
    test('Should return CustomException when it fails', () async {
      when(() => hiveService.allChecklist()).thenThrow(customException);

      final result = await checklistRepositoryImpl.all();

      expect(result.isLeft(), equals(true));
    });
  });

  group('Checklist repository - Create', () {
    test('Should return true when successful', () async {
      when(() => hiveService.insert(any())).thenAnswer(
        (_) => Future.value(),
      );

      final result =
          await checklistRepositoryImpl.create(checkListModelFixture);
      expect(result, const Right(true));
    });
    test('Should return CustomException when it fails', () async {
      when(() => hiveService.insert(any())).thenThrow(customException);

      final result =
          await checklistRepositoryImpl.create(checkListModelFixture);

      expect(result.isLeft(), equals(true));
    });
  });

  group('Checklist repository - Update', () {
    test('Should return true when successful 1', () async {
      when(() => hiveService.insert(any())).thenAnswer(
        (_) => Future.value(),
      );

      final result =
          await checklistRepositoryImpl.update(checkListModelFixture);
      expect(result, const Right(true));
    });
    test('Should return CustomException when it fails', () async {
      when(() => hiveService.insert(any())).thenThrow(customException);

      final result =
          await checklistRepositoryImpl.update(checkListModelFixture);

      expect(result.isLeft(), equals(true));
    });
  });

  group('Checklist repository - Delete', () {
    test('Should return true when successful', () async {
      when(() => hiveService.deleteAll(any())).thenAnswer(
        (_) => Future.value(),
      );

      final result =
          await checklistRepositoryImpl.delete([checkListModelFixture]);
      expect(result, const Right(true));
    });
    test('Should return CustomException when it fails', () async {
      when(() => hiveService.deleteAll(any())).thenThrow(customException);

      final result =
          await checklistRepositoryImpl.delete([checkListModelFixture]);

      expect(result.isLeft(), equals(true));
    });
  });
}
