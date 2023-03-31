import 'package:checklist_app/core/services/snackbar_service.dart';
import 'package:checklist_app/model/exception.dart';
import 'package:checklist_app/provider/checklist_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fixture/checklist_fixtures.dart';
import '../mocks.dart';

void main() {
  late MockChecklistRepository mockChecklistRepository;
  late ChecklistProvider checklistProvider;
  late SnackBarService snackBarService;

  setUp(() {
    mockChecklistRepository = MockChecklistRepository();
    snackBarService = SnackBarService();
    checklistProvider = ChecklistProvider(
      checklistRepository: mockChecklistRepository,
      snackBarService: snackBarService,
    );
    registerFallbackValue(checkListModelFixture);
  });

  group('Auth Provider - All', () {
    test('Should return a true when successful', () async {
      when(
        () => mockChecklistRepository.all(),
      ).thenAnswer((_) => Future.value(const Right([])));

      final result = await checklistProvider.getAll();

      expect(result, equals(true));
    });
    test('Should return a false when un-successful', () async {
      when(
        () => mockChecklistRepository.all(),
      ).thenAnswer((_) =>
          Future.value(Left(CustomException(message: 'Failed to get items'))));

      final result = await checklistProvider.getAll();

      expect(result, equals(false));
    });
  });

  group('Auth Provider - Create', () {
    test('Should return a true when successful', () async {
      when(
        () => mockChecklistRepository.create(any()),
      ).thenAnswer((_) => Future.value(const Right(true)));

      final result = await checklistProvider.create(checkListModelFixture);

      expect(result, equals(true));
    });
    test('Should return a false when un-successful', () async {
      when(
        () => mockChecklistRepository.create(any()),
      ).thenAnswer(
          (_) => Future.value(Left(CustomException(message: 'sync failed'))));

      final result = await checklistProvider.create(checkListModelFixture);

      expect(result, equals(false));
    });
  });

  group('Auth Provider - Update', () {
    test('Should return a true when successful', () async {
      when(
        () => mockChecklistRepository.update(any()),
      ).thenAnswer((_) => Future.value(const Right(true)));

      final result = await checklistProvider.update(checkListModelFixture);

      expect(result, equals(true));
    });
    test('Should return a false when un-successful', () async {
      when(
        () => mockChecklistRepository.update(any()),
      ).thenAnswer(
          (_) => Future.value(Left(CustomException(message: 'sync failed'))));

      final result = await checklistProvider.update(checkListModelFixture);

      expect(result, equals(false));
    });
  });

  group('Auth Provider - Delete', () {
    test('Should return a true when successful', () async {
      when(
        () => mockChecklistRepository.delete(any()),
      ).thenAnswer((_) => Future.value(const Right(true)));

      final result = await checklistProvider.delete([checkListModelFixture]);

      expect(result, equals(true));
    });
    test('Should return a false when un-successful', () async {
      when(
        () => mockChecklistRepository.delete(any()),
      ).thenAnswer(
          (_) => Future.value(Left(CustomException(message: 'sync failed'))));

      final result = await checklistProvider.delete([checkListModelFixture]);

      expect(result, equals(false));
    });
  });
}
