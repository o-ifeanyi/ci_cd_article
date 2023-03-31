import 'package:checklist_app/core/constants/constants.dart';
import 'package:checklist_app/core/services/hive_service.dart';
import 'package:checklist_app/core/services/snackbar_service.dart';
import 'package:checklist_app/core/util/themes.dart';
import 'package:checklist_app/data/checklist_repository.dart';
import 'package:checklist_app/interface/checklist_repository.dart';
import 'package:checklist_app/provider/checklist_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  final appDataBox = await Hive.openBox(kHiveBoxes.appData.name);
  final checklistBox = await Hive.openBox(kHiveBoxes.checklist.name);

  final currentTheme = appDataBox.get('theme', defaultValue: '');
  ThemeOptions themeOption = ThemeOptions.values.firstWhere(
    (theme) => theme.name == currentTheme,
    orElse: () => ThemeOptions.system,
  );

  // Feature: Checklist
  // Provider
  sl.registerFactory(
    () => ChecklistProvider(checklistRepository: sl(), snackBarService: sl())
      ..currentTheme = themeOption,
  );
  // Repository
  sl.registerLazySingleton<ChecklistRepository>(
    () => ChecklistRepositoryImpl(hiveService: sl()),
  );

  // Services
  sl.registerLazySingleton<HiveService>(() => HiveService(
        appDataBox: appDataBox,
        checklistBox: checklistBox,
      ));
  sl.registerLazySingleton<SnackBarService>(() => SnackBarService());
}
