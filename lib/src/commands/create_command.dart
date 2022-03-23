import 'package:io/io.dart';
import 'package:surf_flutter_starter/src/commands/base_command.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_repository_job.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';

/// Creates new project.
///
/// Project creation is, essentially, series of [Job]'s. If they are completed normally,
/// run() method returns success code & error code - otherwise.
class CreateCommand extends BaseCommand {
  final CloneTemplateJob _cloneTemplateRepositoryJob;

  @override
  String get description => 'Creates new Flutter project based on Surf project template';

  @override
  String get name => 'create';

  /// Constructor, in which [Job]'s implementations are passed.
  CreateCommand(this._cloneTemplateRepositoryJob);

  @override
  Future<int> run() async {
    try {
      await _cloneTemplateRepositoryJob.execute();

      return ExitCode.success.code;
    } on JobException {
      return ExitCode.usage.code;
    } on Exception {
      return ExitCode.usage.code;
    }
  }
}
