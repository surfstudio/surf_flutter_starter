import 'dart:io';

import 'package:surf_flutter_starter/src/services/settings_service.dart';

/// Customizes project specific configuration.
///
/// Is different from [SettingsService] because [ConfigService] only deals with
/// project creation process & its' specifics. It does not care about its' CLI
/// dependencies or version management.
class ConfigService {
  /// Destination, in which new project is created.
  ///
  /// For the moment, does not include project's name.
  // TODO(taranov): refactor implementation to be based on user input.
  final workingPath = '${Directory.current.path}\\temp';
}
