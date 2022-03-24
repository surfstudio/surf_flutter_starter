import 'package:surf_flutter_starter/src/config/config_parameter.dart';

// TODO(taranov): Documentation.
/// Stores values & options, describing new project.
class Config {
  /// Parameters, that define config.
  final ProjectPath projectPath;

  ///
  final ProjectName projectName;

  ///
  final AppID appID;

  ///
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

  ///
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
