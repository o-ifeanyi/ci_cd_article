import 'package:checklist_app/core/services/hive_service.dart';
import 'package:checklist_app/interface/checklist_repository.dart';
import 'package:mocktail/mocktail.dart';

// Repositories
class MockChecklistRepository extends Mock implements ChecklistRepository {}

// Service
class MockHiveService extends Mock implements HiveService {}
