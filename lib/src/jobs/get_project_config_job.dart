import 'package:surf_flutter_starter/src/config/config_builder.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/repositories/config_repository.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

class GetProjectConfigJob implements Job {
  final ConfigRepository _configRepository;
  final ConfigBuilder _configBuilder;

  GetProjectConfigJob(
    this._configRepository,
    this._configBuilder,
  );

  @override
  Future<void> execute() async {
    try {
      final _builder = _configBuilder;

      // TODO(taranov): Finish user input.
      _builder.buildProjectPath('path');

      _builder.buildProjectName('projectName');

      _builder.buildAppID('appID');

      final _config = _builder.build();

      Logger.info('MinimalConfig is built');
      Logger.info('$_config');
    } on RepositoryException catch (e) {
      Logger.error(e.message);
    }
  }
}
