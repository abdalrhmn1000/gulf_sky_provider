import 'package:gulf_sky_provider/domain/core/utils/app_environment.dart';
import 'package:injectable/injectable.dart';

abstract class Configuration {
  String get name;

  String get getBaseUrl;
}

@LazySingleton(as: Configuration, env: [AppEnvironment.dev])
class DevConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'http://skygulf.zona.ae';

  @override
  String get name => 'development';
}

@LazySingleton(as: Configuration, env: [AppEnvironment.staging])
class StagingConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'http://skygulf.zona.ae';

  @override
  String get name => 'staging';
}

@LazySingleton(as: Configuration, env: [AppEnvironment.prod])
class ProductionConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'http://skygulf.zona.ae';

  @override
  String get name => 'production';
}
