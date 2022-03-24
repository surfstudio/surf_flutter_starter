import 'package:surf_flutter_starter/src/services/config_service.dart';

/// Stores & manages settings
///
/// Settings are different options and flags, that are not directly corresponded to
/// project itself. It's a low-level structure of variables & settings.
///
/// Is different from [ConfigService], because [SettingsService] does not bear
/// project-specific implementation. It only deals with higher levels of abstractions
/// such as version management or platform specifications.
class SettingsService {
  /// Describes if console output is verbose or not.
  bool isVerbose = false;

  // TODO(taranov): change implementation, in case url may be changed in runtime.
  /// Url for template, which is used in project generation process.
  String get surfFlutterAppTemplateUrl => _surfFlutterAppTemplateUrl;

  /// Constructor for settings.
  SettingsService();
}

const _surfFlutterAppTemplateUrl =
    'https://github.com/surfstudio/surf-flutter-app-template/archive/refs/heads/main.zip';
