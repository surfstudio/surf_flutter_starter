import 'dart:io';

import 'package:io/io.dart';
import 'package:surf_flutter_starter/src/commands/base_command.dart';
import 'package:surf_flutter_starter/src/config/config_builder.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/executor.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

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
  CreateCommand(this._executor) {
    argParser
      ..addOption(
        'project-path',
        help: 'Set path, in which project is going to be created.',
        abbr: 'p',
        mandatory: true,
      )
      ..addOption(
        'project-name',
        help: 'Set Flutter project name; "set_like_this". \nSee also: https://dart.dev/tools/pub/pubspec#name',
        abbr: 'n',
        mandatory: true,
      )
      ..addOption(
        'app-id',
        help:
            'Set App id like this: "com.example.project". \nSee also: https://developer.android.com/studio/build/configure-app-module#set_the_application_id',
        abbr: 'a',
        mandatory: true,
      );
  }

  @override
  Future<int> run() async {
    final path = argResults!['project-path'] as String;

    final _builder = MinimalConfigBuilder();
    if (!await FileSystemEntity.isDirectory(path)) {
      Logger.error('$path is not a Directory.');
      return ExitCode.usage.code;
    }
    Logger.fine('$path is Directory.');

    _builder.buildProjectPath(path);

    final projectName = argResults!['project-name'] as String;
    _builder.buildProjectName(projectName);

    final appID = argResults!['app-id'] as String;
    _builder.buildAppID(appID);

    final _config = _builder.build();
    Logger.info('MinimalConfig is built');
    Logger.info('$_config');

    try {
      await _executor.run(_config);
      return ExitCode.success.code;
    } on ExecutorException {
      return ExitCode.usage.code;
    }
  }
}
