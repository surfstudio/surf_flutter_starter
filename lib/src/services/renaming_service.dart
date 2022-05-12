import 'package:io/io.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Renames project files & content.
///
/// Runs [https://pub.dev/packages/rename] to do so.
class RenamingService {
  /// Runs rename-package.
  Future<void> runRename({
    required String executablePath,
    required String projectName,
    required String bundleId,
    required bool isAndroidSupport,
    required bool isIOSSupport,
    required bool isMacOSSupport,
    required bool isLinuxSupport,
  }) async {
    final processManager = ProcessManager();
    // Initialization of 'rename' package.
    final initProcess = await processManager.spawn(
      'dart',
      [
        'pub',
        'global',
        'activate',
        'rename',
      ],
      workingDirectory: executablePath,
    );

    final initExitCode = await initProcess.exitCode;
    Logger.fine('Renaming service. InitExitCode: $initExitCode');

    // Running 'rename' package.
    final supportedPlatforms = <String>[];
    if (isAndroidSupport) {
      supportedPlatforms.add('android');
    }
    if (isIOSSupport) {
      supportedPlatforms.add('ios');
    }
    if (isMacOSSupport) {
      supportedPlatforms.add('macOS');
    }
    if (isLinuxSupport) {
      supportedPlatforms.add('linux');
    }
    final name = 'surf-flutter-app-template-main';
    final runProcess = await processManager.spawn(
      'dart',
      [
        'pub',
        'global',
        'run',
        'rename',
        '--appname',
        projectName,
        '--bundleId',
        bundleId,
        '--target',
        ...supportedPlatforms,
      ],
      workingDirectory: '$executablePath\\$name',
    );

    final runExitCode = await runProcess.exitCode;
    Logger.fine('Renaming service. RunExitCode: $runExitCode');

    return;
  }
}
