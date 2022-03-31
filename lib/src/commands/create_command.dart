import 'package:io/io.dart';
import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/commands/base_command.dart';
import 'package:surf_flutter_starter/src/executor.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';

/// Creates new project.
///
/// Project creation is, essentially, run of [Executor]. If it completes normally,
/// run() method returns success code & error code - otherwise.
class CreateCommand extends BaseCommand {
  final Executor _executor;

  @override
  String get description => 'Creates new Flutter project based on Surf project template';

  @override
  String get name => 'create';

  /// Constructor, in which [Job]'s implementations are passed.
  CreateCommand(this._executor);

  @override
  Future<int> run() async {
    try {
      await _executor.run();
      return ExitCode.success.code;
    } on ExecutorException {
      return ExitCode.usage.code;
    }
  }
}
