import 'package:checklist_app/core/services/hive_service.dart';
import 'package:checklist_app/interface/checklist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:checklist_app/model/exception.dart';
import 'package:checklist_app/model/checklist.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  final HiveService hiveService;

  ChecklistRepositoryImpl({required this.hiveService});

  @override
  Future<Either<CustomException, List<ChecklistModel>>> all() async {
    try {
      final all = await hiveService.allChecklist();

      return Right(all);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> create(ChecklistModel checklist) async {
    try {
      await hiveService.insert(checklist);
      return const Right(true);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> delete(
      List<ChecklistModel> checklists) async {
    try {
      await hiveService.deleteAll(checklists.map((e) => e.id));
      return const Right(true);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> update(ChecklistModel checklist) async {
    try {
      await hiveService.insert(checklist);
      return const Right(true);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
