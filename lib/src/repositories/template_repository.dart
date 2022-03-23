import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/services/config_service.dart';
import 'package:surf_flutter_starter/src/services/network_service.dart';
import 'package:surf_flutter_starter/src/services/settings_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

///Repository for managing basic project template
class TemplateRepository {
  final NetworkService _networkService;
  final SettingsService _settingsService;
  final ConfigService _configService;

  /// Constructor, in which services are passed.
  const TemplateRepository(
    this._networkService,
    this._settingsService,
    this._configService,
  );

  /// Gets project template & saves it in working directory.
  Future<void> getTemplate() async {
    try {
      await _networkService.download(
        url: _settingsService.surfFlutterAppTemplateUrl,
        path: _configService.workingPath,
      );
    } on NetworkException catch (e) {
      logger.stderr(e.toString());
      throw RepositoryException(e.toString());
    }
  }
}