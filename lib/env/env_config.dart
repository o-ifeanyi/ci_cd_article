abstract class BaseConfig {
  String get baseUrl;
}

class StagingEnv implements BaseConfig {
  @override
  String get baseUrl => '';
}

class ProductionEnv implements BaseConfig {
  @override
  String get baseUrl => '';
}
