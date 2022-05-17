import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/creators/creator.dart';

/// Builds [Config].
abstract class ConfigBuilder {
  /// [Config] private instance.
  ///
  /// Default to an empty config with empty parameters.
  Config _config = Config.empty();

  /// Builds [ProjectPath].
  void buildProjectPath(String projectPath);

  /// Builds [ProjectName].
  void buildProjectName(String projectName);

  /// Builds [AppLabel].
  void buildAppLabel(String appLabel);

  /// Builds [AppID].
  void buildAppID(String appID);

  /// Returns [Config] instance.
  Config build() => _config;

  /// Builds [Config] with given parameters.
  Config buildWithParameters({
    required String projectPathValue,
    required String projectNameValue,
    required String appLabelValue,
    required String appIDValue,
  }) {
    buildProjectPath(projectPathValue);
    buildProjectName(projectNameValue);
    buildAppLabel(appLabelValue);
    buildAppID(appIDValue);
    return build();
  }
}

/// 'Config'-MVP, used for initial [Creator.start].
///
/// Consists of:
/// [ProjectName],
/// [ProjectPath],
/// [AppLabel],
/// [AppID].
///
/// Is bare minimal of a project entity & its builder only used for
/// quick & easy [Creator.start].
class MinimalConfigBuilder extends ConfigBuilder {
  @override
  void buildProjectPath(String value) {
    _config = _config.copyWith(projectPathValue: ProjectPath(value));
  }

  @override
  void buildProjectName(String value) {
    _config = _config.copyWith(projectNameValue: ProjectName(value));
  }

  @override
  void buildAppLabel(String value) {
    _config = _config.copyWith(appLabelValue: AppLabel(value));
  }

  @override
  void buildAppID(String value) {
    _config = _config.copyWith(appIDValue: AppID(value));
  }

  @override
  Config buildWithParameters({
    required String projectPathValue,
    required String projectNameValue,
    required String appLabelValue,
    required String appIDValue,
  }) {
    buildProjectPath(projectPathValue);
    assert(_config.projectPath.isValid);
    buildProjectName(projectNameValue);
    assert(_config.projectName.isValid);
    buildAppLabel(appLabelValue);
    assert(_config.appLabel.isValid);
    buildAppID(appIDValue);
    assert(_config.appID.isValid);

    return build();
  }
}
