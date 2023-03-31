import 'package:checklist_app/core/services/snackbar_service.dart';
import 'package:checklist_app/core/util/themes.dart';
import 'package:checklist_app/interface/checklist_repository.dart';
import 'package:checklist_app/model/checklist.dart';
import 'package:flutter/material.dart';

enum CheckState { idle, sync, getAll, create, update, delete }

class ChecklistProvider extends ChangeNotifier {
  final ChecklistRepository checklistRepository;
  final SnackBarService snackBarService;
  ChecklistProvider(
      {required this.checklistRepository, required this.snackBarService});

  CheckState _checkState = CheckState.idle;
  CheckState get checkState => _checkState;
  void setState(CheckState state) {
    _checkState = state;
    notifyListeners();
  }

  ThemeOptions _currentTheme = ThemeOptions.system;
  ThemeOptions get currentTheme => _currentTheme;
  set currentTheme(ThemeOptions value) {
    _currentTheme = value;
    notifyListeners();
  }

  List<ChecklistModel> allChecklist = [];

  List<ChecklistModel> _marked = [];
  List<ChecklistModel> get marked => _marked;

  void markAll(bool val) {
    _marked.clear();
    if (val) {
      _marked.addAll(allChecklist);
    }
    notifyListeners();
  }

  void updateMarked(ChecklistModel checklist) {
    if (_marked.contains(checklist)) {
      _marked.remove(checklist);
    } else {
      _marked.add(checklist);
    }
    notifyListeners();
  }

  Future<bool> getAll() async {
    setState(CheckState.getAll);
    final allEither = await checklistRepository.all();
    setState(CheckState.idle);
    return allEither.fold(
      (exc) {
        snackBarService.displayMessage(exc.message);
        return false;
      },
      (checklists) {
        allChecklist = checklists;
        notifyListeners();
        return true;
      },
    );
  }

  Future<bool> create(ChecklistModel checklist) async {
    setState(CheckState.create);
    final createEither = await checklistRepository.create(checklist);
    setState(CheckState.idle);
    return createEither.fold(
      (exc) {
        snackBarService.displayMessage(exc.message);
        return false;
      },
      (done) => done,
    );
  }

  Future<bool> update(ChecklistModel checklist) async {
    setState(CheckState.update);
    final updateEither = await checklistRepository.update(checklist);
    setState(CheckState.idle);
    return updateEither.fold(
      (exc) {
        snackBarService.displayMessage(exc.message);
        return false;
      },
      (done) => done,
    );
  }

  Future<bool> delete(List<ChecklistModel> checklist) async {
    setState(CheckState.delete);
    final deleteEither = await checklistRepository.delete(checklist);
    setState(CheckState.idle);
    return deleteEither.fold(
      (exc) {
        snackBarService.displayMessage(exc.message);
        return false;
      },
      (done) => done,
    );
  }
}
