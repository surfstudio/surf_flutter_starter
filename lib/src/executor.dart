import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_repository_job.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/services/config_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Executes [Job]'s.
///
/// Project creation is, essentially, series of [Job]'s.
class Executor {
  final ConfigService _configService;
  final CloneTemplateJob _cloneTemplateJob;

  /// Constructor for [Executor]
  const Executor(
    this._configService,
    this._cloneTemplateJob,
  );

  ///
  Future<void> run(Config config) async {
    try {
      // Setting Config object to it's instance, so that Job's can access it via ConfigService.
      _configService.setConfig(config);

      await _cloneTemplateJob.execute();
    } on JobException catch (e) {
      Logger.error(e.toString());
      throw ExecutorException(e.message);
    }
    return;
  }
}
