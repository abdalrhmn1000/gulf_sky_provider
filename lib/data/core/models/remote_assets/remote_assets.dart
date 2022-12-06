import 'package:injectable/injectable.dart';
import 'package:gulf_sky_provider/data/core/utils/configuration.dart';

@LazySingleton()
class RemoteAssets {
  final Configuration configuration;

  RemoteAssets(this.configuration);

  String get url => configuration.getBaseUrl;
}
