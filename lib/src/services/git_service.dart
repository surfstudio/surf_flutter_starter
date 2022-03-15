import 'package:process_run/cmd_run.dart';
import 'package:surf_flutter_starter/constants.dart';
import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

class GitService {
  Future<void> cloneTemplateRepository() async {
    final args = [
      'clone',
      '--progress',
      surfFlutterAppTemplateUrl,
      '${currentDirectory.path}\\$templateProjectName',
    ];

    final process = await runExecutableArguments(
      'git',
      args,
      stdout: consoleController.stdoutSink,
      stderr: consoleController.stderrSink,
    );

    if (process.exitCode != 0) {
      logger.trace(process.stderr.toString());
      throw const GitException('Could not git clone repository');
    }
  }
}
