import 'package:checklist_app/model/checklist.dart';
import 'package:checklist_app/model/exception.dart';
import 'package:dartz/dartz.dart';

abstract class ChecklistRepository {
  Future<Either<CustomException, List<ChecklistModel>>> all();
  Future<Either<CustomException, bool>> create(ChecklistModel checklist);
  Future<Either<CustomException, bool>> update(ChecklistModel checklist);
  Future<Either<CustomException, bool>> delete(List<ChecklistModel> checklists);
}
