import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_repository_job.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Executes [Job]'s.
///
/// Project creation is, essentially, series of [Job]'s.
class Executor {
  final CloneTemplateJob _cloneTemplateJob;

  /// Constructor for [Executor]
  const Executor(this._cloneTemplateJob);

  ///
  // TODO(taranov): add config-object to method 'run'
  Future<void> run(Object? config) async {
    try {
      await _cloneTemplateJob.execute();
    } on JobException catch (e) {
      Logger.error(e.message);
    }
    return;
  }
}
