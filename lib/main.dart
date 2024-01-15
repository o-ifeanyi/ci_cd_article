import 'package:checklist_app/core/routes/router.dart';
import 'package:checklist_app/core/util/app_aware.dart';
import 'package:checklist_app/core/util/themes.dart';
import 'package:checklist_app/env/env.dart';
import 'package:checklist_app/injection_container.dart';
import 'package:checklist_app/provider/checklist_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  Env().initConfig();
  await init();

  if (kIsWeb || kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => sl<ChecklistProvider>()),
    ],
    // Uncomment to run in preview mode
    // child: DevicePreview(
    //   enabled: true,
    //   builder: (context) => const MyApp(),
    // ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = AppRoute.router;
    return ScreenUtilInit(
      designSize: MediaQuery.sizeOf(context),
      minTextAdapt: true,
      child: AppAware(
        child: Consumer<ChecklistProvider>(
          builder: (context, provider, child) {
            return MaterialApp.router(
              routeInformationProvider: _router.routeInformationProvider,
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
              title: 'Checklist',
              theme: AppTheme.themeOptions(provider.currentTheme),
              darkTheme: AppTheme.darkTheme(),
              themeMode: AppTheme.themeMode(context),
            );
          },
        ),
      ),
    );
  }
}
