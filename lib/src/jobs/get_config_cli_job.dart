import 'package:surf_flutter_starter/src/config/config.dart';
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
    final config = _configRepository.getConfigFromUserInput();

    Logger.fine('Config is built');
    Logger.fine('$config');
    return config;
  }
}
