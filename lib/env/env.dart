import 'package:flutter/foundation.dart';

import 'env_config.dart';

class Env {
  factory Env() {
    return _singleton;
  }

  Env._internal();

  static final Env _singleton = Env._internal();

  late BaseConfig _config;
  BaseConfig get config => _config;

  initConfig() {
    if (kIsWeb)
      _config = ProductionEnv();
    else
      _config = kDebugMode ? StagingEnv() : ProductionEnv();
  }
}
