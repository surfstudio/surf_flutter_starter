import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/services/config_service.dart';
import 'package:surf_flutter_starter/src/services/git_service.dart';
import 'package:surf_flutter_starter/src/services/settings_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

///Repository for managing basic project template
class TemplateRepository {
  final GitService _gitService;
  final SettingsService _settingsService;
  final ConfigService _configService;

  /// Constructor, in which services are passed.
  const TemplateRepository(
    this._gitService,
    this._settingsService,
    this._configService,
  );

  /// Gets project template & saves it in working directory.
  Future<void> getTemplate() async {
    try {
      await _gitService.cloneRepository(
        repositoryUrl: _settingsService.surfFlutterAppTemplateUrl,
        path: _configService.workingPath,
        isShowingProgress: _settingsService.isVerbose,
      );
    } on GitException catch (e) {
      logger.stderr(e.message);
      throw RepositoryException(e.toString());
    }
  }
}
