import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/creators/creator.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_job.dart';
import 'package:surf_flutter_starter/src/jobs/get_config_cli_job.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/services/config_service.dart';

/// Creates Project via CLI interaction.
class InteractiveCLICreator extends Creator {
  final GetConfigCLIJob _getConfigCLIJob;
  final CloneTemplateJob _cloneTemplateJob;
  final ConfigService _configService;

  /// Constructor, in which [Job]s are passed.
  InteractiveCLICreator(
    this._getConfigCLIJob,
    this._cloneTemplateJob,
    this._configService,
  );

  @override
  Future<Config> prepareConfig() async {
    final config = await _getConfigCLIJob.execute();
    return config;
  }

  @override
  Future<void> createByConfig(Config config) async {
    // Setting Config to service's instance, so that all jobs can require it there.
    _configService.setConfig(config);
    // Run series of jobs.
    await _cloneTemplateJob.execute();
  }
}
