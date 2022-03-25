import 'package:surf_flutter_starter/src/config/config_parameter.dart';

/// Describes new project, that is being created.
///
/// Consists of values & parameters, that are being inserted
/// into new project when it's being created by user. User
/// defines those values & parameters whilst interacting with
/// CLI.
class Config {
  /// Directory, in which new project is created.
  final ProjectPath projectPath;

  /// Name of new project.
  ///
  /// See also: https://dart.dev/tools/pub/pubspec#name
  final ProjectName projectName;

  /// Application ID.
  ///
  /// See also: https://developer.android.com/studio/build/configure-app-module#set_the_application_id
  final AppID appID;

  /// Validity of config.
  ///
  /// Validity is, as a whole, based on validity of all Config's [ConfigParameter].
  bool get isValid => projectPath.isValid && projectName.isValid && appID.isValid;

  /// [Config] constructor, in which parameters are passed.
  const Config({
    required this.projectPath,
    required this.projectName,
    required this.appID,
  });

  /// [Config] factory, that makes an empty config.
  factory Config.empty() {
    return Config(
      projectPath: ProjectPath.empty(),
      projectName: ProjectName.empty(),
      appID: AppID.empty(),
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
    AppID? appIDValue,
  }) {
    return Config(
      projectPath: projectPathValue ?? projectPath,
      projectName: projectNameValue ?? projectName,
      appID: appIDValue ?? appID,
    );
  }
}
