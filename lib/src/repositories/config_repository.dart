import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/config/config_builder.dart';
import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/services/config_service.dart';
import 'package:surf_flutter_starter/src/services/dialog_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

const _projectNamePrompt = 'Please, type in project name (like_this):';
const _projectPathPrompt = 'Please, type in path to project (C:\\path\\to\\project):';
const _appIDPrompt = 'Please, type in app ID (com.example.id):';

/// Handles all [Config] interactions.
class ConfigRepository {
  final DialogService _dialogService;
  final ConfigService _configService;
  late final ConfigBuilder _configBuilder;

  /// Gets [ProjectName] from user as 'String'.
  String get _getProjectNameInput => _dialogService.getUserInput(userPrompt: _projectNamePrompt);

  /// Gets [ProjectPath] from user as 'String'.
  String get _getProjectPathInput => _dialogService.getUserInput(userPrompt: _projectPathPrompt);

  /// Gets [AppID] from user as 'String'.
  String get _getProjectAppIDInput => _dialogService.getUserInput(userPrompt: _appIDPrompt);

  /// Constructor, in which services are passed.
  ConfigRepository(
    this._dialogService,
    this._configService,
  ) {
    // Pass the builder's instance.
    _configBuilder = _configService.configBuilder;
  }

  /// Gets [Config], that is typed by user.
  ///
  /// Builds series of [ConfigParameter]s along the way.
  /// Uses [DialogService] to do so.
  ///
  /// Returns [Config] instance, that is built by [ConfigBuilder].
  Config getConfigFromUserInput() {
    try {
      final projectName = _getProjectNameInput;
      _configBuilder.buildProjectName(projectName);

      final projectPath = _getProjectPathInput;
      _configBuilder.buildProjectPath(projectPath);

      final appID = _getProjectAppIDInput;
      _configBuilder.buildAppID(appID);

      return _configBuilder.build();
    } on InputException catch (e) {
      Logger.error(e.message);
      throw RepositoryException(e.message);
    }
  }
}
