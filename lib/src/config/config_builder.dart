import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/config/config_parameter.dart';

// TODO(taranov): Documentation.
///
abstract class ConfigBuilder {
  ///
  Config _config = Config.empty();

  ///
  void buildProjectPath(String _) => _config.copyWith(projectPathValue: ProjectPath.empty());

  ///
  void buildProjectName(String _) => _config.copyWith(projectNameValue: ProjectName.empty());

  ///
  void buildAppID(String _) => _config.copyWith(appIDValue: AppID.empty());

  ///
  Config build() => _config;

  ///
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

///
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
