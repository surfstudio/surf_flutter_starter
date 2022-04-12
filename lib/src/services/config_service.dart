import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/config/config_builder.dart';

/// Customizes project specific [Config].
///
/// Holds [Config] instance.
class ConfigService {
  /// Instance of [ConfigBuilder] as an 'interface'.
  final ConfigBuilder configBuilder;

  /// Gets [Config] current instance.
  Config get configInstance => _configInstance;

  /// Initial, empty [Config].
  Config _configInstance = Config.empty();

  /// Constructor, in which builder is passed.
  ConfigService(this.configBuilder);

  /// Sets current instance to new [Config].
  void setConfig(Config newConfig) => _configInstance = newConfig;
}
