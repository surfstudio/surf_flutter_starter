import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_repository_job.dart';
import 'package:surf_flutter_starter/src/jobs/get_project_config_job.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Executes [Job]'s.
///
/// Project creation is, essentially, series of [Job]'s.
class Executor {
  final GetConfigCLIJob _getProjectConfigJob;
  final CloneTemplateJob _cloneTemplateJob;

  /// Constructor for [Executor].
  const Executor(
    this._getProjectConfigJob,
    this._cloneTemplateJob,
  );

  /// [Executor]'s entry point for creating projects.
  ///
  /// Uses series of [Job] runs to do so.
  Future<void> run() async {
    try {
      await _getProjectConfigJob.execute();
      await _cloneTemplateJob.execute();
    } on JobException catch (e) {
      Logger.error(e.toString());
      throw ExecutorException(e.message);
    }
    return;
  }
}
