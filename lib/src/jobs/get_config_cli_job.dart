import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/repositories/config_repository.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Gets [Config] from user input.
class GetConfigCLIJob implements Job {
  final ConfigRepository _configRepository;

  /// Constructor, in which repositories are passed.
  GetConfigCLIJob(this._configRepository);

  /// Gets [Config] from user input.
  Future<Config> execute() async {
    try {
      final config = _configRepository.getConfigFromUserInput();

      Logger.info('Config is built');
      Logger.info('$config');
      return config;
    } on RepositoryException catch (e) {
      Logger.error(e.message);
      throw JobException(e.message);
    }
  }
}
