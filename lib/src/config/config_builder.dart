import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/executor.dart';

/// Builds config.
abstract class ConfigBuilder {
  /// [Config] private instance.
  ///
  /// Default to an empty config with empty parameters.
  Config _config = Config.empty();

  /// Builds [ProjectPath].
  void buildProjectPath(String _) => _config.copyWith(projectPathValue: ProjectPath.empty());

  /// Builds [ProjectName].
  void buildProjectName(String _) => _config.copyWith(projectNameValue: ProjectName.empty());

  /// Builds [AppID].
  void buildAppID(String _) => _config.copyWith(appIDValue: AppID.empty());

  /// Returns [Config] instance.
  Config build() => _config;

  /// Builds [Config] with given parameters.
  Config buildWithParameters({
    required String projectPathValue,
    required String projectNameValue,
    required String appIDValue,
  }) {
    buildProjectPath(projectPathValue);
    buildProjectName(projectNameValue);
    buildAppID(appIDValue);
    return build();
  }
}

/// 'Config'-MVP, used for initial [Executor] run.
///
/// Consists of [ProjectName], [ProjectPath] & [AppID].
/// Is bare minimal of a project entity & its builder only used for
/// quick & easy [Executor] start.
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
  void buildAppID(String value) {
    _config = _config.copyWith(appIDValue: AppID(value));
  }

  @override
  Config buildWithParameters({
    required String projectPathValue,
    required String projectNameValue,
    required String appIDValue,
  }) {
    buildProjectPath(projectPathValue);
    assert(_config.projectPath.isValid);
    buildProjectName(projectNameValue);
    assert(_config.projectName.isValid);
    buildAppID(appIDValue);
    assert(_config.appID.isValid);

    return build();
  }
}
