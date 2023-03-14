import 'dart:io';

import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/config/config_builder.dart';
import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/services/dialog_service.dart';
import 'package:surf_flutter_starter/src/utils/replace_path_separators_x.dart';

const _createInCurrentPrompt =
    'Do yoy want to create project in current directory? (Y/N)';
const _projectNamePrompt = 'Enter your project\'s name (like_this):';
const _appLabelPrompt =
    'Enter your project\'s label (label). Something like (App Name):';
const _appIDPrompt = 'Enter your project\'s application ID (com.example.id):';

/// Handles all [Config] interactions.
class ConfigRepository {
  final DialogService _dialogService;
  final ConfigBuilder _configBuilder;

  final _projectPathPrompt =
      'Enter path to project (C:\\path\\to\\project):'.replacePathSeparators();

  /// Constructor, in which services are passed.
  ConfigRepository(
    this._dialogService,
    this._configBuilder,
  ) {
    // Pass the builder's instance.
  }

  /// Gets [Config], that is typed by user.
  ///
  /// Builds series of [ConfigParameter]s along the way.
  /// Uses [DialogService] to do so.
  ///
  /// Returns [Config] instance, that is built by [ConfigBuilder].
  Config getConfigFromUserInput() {
    final projectPath = _getProjectPath();
    _configBuilder.buildProjectPath(projectPath);

    final projectName =
        _dialogService.getUserInput(userPrompt: _projectNamePrompt);
    _configBuilder.buildProjectName(projectName);

    final appLabel = _dialogService.getUserInput(userPrompt: _appLabelPrompt);
    _configBuilder.buildAppLabel(appLabel);

    final appID = _dialogService.getUserInput(userPrompt: _appIDPrompt);
    _configBuilder.buildAppID(appID);

    return _configBuilder.build();
  }

  String _getProjectPath() {
    final isInCurrentDirectory = _dialogService.isYesInput(
        userPrompt: '$_createInCurrentPrompt \n${Directory.current.path}');
    if (isInCurrentDirectory) {
      return Directory.current.path;
    }
    final projectPath =
        _dialogService.getUserInput(userPrompt: _projectPathPrompt);
    return projectPath;
  }
}
