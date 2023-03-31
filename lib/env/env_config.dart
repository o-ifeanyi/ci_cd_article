import 'package:checklist_app/core/util/config.dart';
import 'package:checklist_app/env/secrets.dart';

abstract class BaseConfig {
  String get baseUrl;
}

class StagingEnv implements BaseConfig {
  @override
  String get baseUrl =>
      Config.isAndroid ? 'http://10.0.2.2:8080/' : 'http://localhost:8080/';
}

class ProductionEnv implements BaseConfig {
  @override
  String get baseUrl => '${Secrets.PROD_URL}';
}
