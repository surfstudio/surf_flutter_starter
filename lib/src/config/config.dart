import 'package:surf_flutter_starter/src/config/config_parameter.dart';

/// Describes new project, that is being created.
///
/// Consists of values & parameters, that are being inserted
/// into new project when it's being created by user. User
/// defines those values & parameters as [ConfigParameter]s
/// whilst interacting with CLI.
class Config {
  /// Url for template, which is used in project generation process.
  static const templateUrl =
      'https://github.com/surfstudio/surf-flutter-app-template/archive/refs/heads/main.zip';

  /// Default state of `Android` target.
  static const defaultAndroidSupport = true;

  /// Default state of `MacOs` target.
  static const defaultIOSSupport = true;

  /// Default state of `iOS` target.
  static const defaultMacOSSupport = false;

  /// Default state of `Linux` target.
  static const defaultLinuxSupport = false;

  /// Directory, in which new project is created.
  final ProjectPath projectPath;

  /// Name of new project.
  ///
  /// See also:
  /// * https://dart.dev/tools/pub/pubspec#name
  final ProjectName projectName;

  /// Application Label (name).
  ///
  /// See also:
  /// * https://developer.android.com/guide/topics/manifest/manifest-intro#iconlabel
  final AppLabel appLabel;

  /// Application ID.
  ///
  /// See also:
  /// * https://developer.android.com/studio/build/configure-app-module#set_the_application_id
  final AppID appID;

  /// Validity of [Config].
  ///
  /// Validity is, as a whole, based on validity of all [Config]'s [ConfigParameter].
  bool get isValid => projectPath.isValid && projectName.isValid && appID.isValid;

  /// [Config] constructor, in which parameters are passed.
  const Config({
    required this.projectPath,
    required this.projectName,
    required this.appLabel,
    required this.appID,
  });

  /// [Config] factory, that makes an empty config.
  factory Config.empty() {
    return Config(
      projectPath: ProjectPath(null),
      projectName: ProjectName(null),
      appLabel: AppLabel(null),
      appID: AppID(null),
    );
  }

  @override
  String toString() {
    return 'Config(valid: $isValid): $projectPath $projectName $appID';
  }

  /// Copies [Config] with given parameters.
  ///
  /// Is used for basic immutability & persistence.
  Config copyWith({
    ProjectPath? projectPathValue,
    ProjectName? projectNameValue,
    AppLabel? appLabelValue,
    AppID? appIDValue,
  }) {
    return Config(
      projectPath: projectPathValue ?? projectPath,
      projectName: projectNameValue ?? projectName,
      appLabel: appLabelValue ?? appLabel,
      appID: appIDValue ?? appID,
    );
  }
}
