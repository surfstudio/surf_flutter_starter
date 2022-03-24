import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/services/settings_service.dart';

/// Customizes project specific configuration.
///
/// Is different from [SettingsService] because [ConfigService] only deals with
/// project creation process & its' specifics. It does not care about its' CLI
/// dependencies or version management. Holds [Config] instance.
class ConfigService {
  ///
  Config get configInstance => _configInstance;

  Config _configInstance = Config.empty();

  ///
  ConfigService();

  ///
  void setConfig(Config newConfig) => _configInstance = newConfig;
}
