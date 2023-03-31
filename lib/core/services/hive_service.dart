import 'package:checklist_app/core/util/themes.dart';
import 'package:checklist_app/model/checklist.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final Box appDataBox;
  final Box checklistBox;

  HiveService({
    required this.appDataBox,
    required this.checklistBox,
  });

  Future<void> clearAll() async {
    await appDataBox.clear();
    await checklistBox.clear();
  }

  Future<void> setToken(String token) async {
    return appDataBox.put('token', token);
  }

  String getToken() {
    return appDataBox.get('token') ?? '';
  }

  Future<void> setTheme(ThemeOptions themeOption) async {
    return appDataBox.put('theme', themeOption.name);
  }

  Future<void> insert(ChecklistModel checklist) async {
    return checklistBox.put(checklist.id, checklist.toMap());
  }

  Future<void> insertAll(List<ChecklistModel> checklists,
      {bool clearSync = true}) async {
    final Map<dynamic, dynamic> data = {};
    for (var checklist in checklists) {
      data[checklist.id] = checklist.toMap();
    }
    await checklistBox.clear();
    await checklistBox.putAll(data);
    return;
  }

  Future<void> deleteAll(Iterable<String> ids) async {
    return checklistBox.deleteAll(ids);
  }

  Future<List<ChecklistModel>> allChecklist() async {
    final data = checklistBox.values.toList();
    return data.map((e) => ChecklistModel.fromJson(e)).toList();
  }
}
