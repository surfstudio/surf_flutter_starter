import 'package:io/io.dart';
import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/commands/i_command.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_repository_job.dart';

class CreateCommand extends ICommand {
  final CloneTemplateRepositoryJob _cloneTemplateRepositoryJob;

  @override
  String get description => 'Creates new Flutter project based on Surf project template';

  @override
  String get name => 'create';

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
