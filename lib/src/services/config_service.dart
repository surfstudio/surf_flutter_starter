import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/services/settings_service.dart';

/// Customizes project specific configuration.
///
/// Is different from [SettingsService] because [ConfigService] only deals with
/// project creation process & its' specifics. It does not care about its' CLI
/// dependencies or version management. Holds [Config] instance.
class ConfigService {
  /// Gets [Config] current instance.
  Config get configInstance => _configInstance;

  /// Initial, empty [Config].
  Config _configInstance = Config.empty();

  /// Constructor for [ConfigService].
  ConfigService();

  /// Sets current instance to new [Config].
  void setConfig(Config newConfig) => _configInstance = newConfig;
}
