import 'package:process_run/cmd_run.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Service of git & git-like operations, used for dealing with VCS.
class GitService {
  /// Clones repository to specified location.
  Future<void> cloneRepository({
    required String repositoryUrl,
    required String path,
    required bool isShowingProgress,
  }) async {
    final args = [
      'clone',
      repositoryUrl,
      path,
    ];
    if (isShowingProgress) {
      args.add('--progress');
    }

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
