import 'package:checklist_app/env/env.dart';

typedef JsonMap = Map<String, dynamic>;

final kBaseUrl = Env().config.baseUrl;

enum kHiveBoxes { appData, checklist, sync }
