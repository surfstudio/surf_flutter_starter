import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:io/io.dart';
import 'package:surf_flutter_starter/src/commands/create_command.dart';
import 'package:surf_flutter_starter/src/executor.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_repository_job.dart';
import 'package:surf_flutter_starter/src/repositories/template_repository.dart';
import 'package:surf_flutter_starter/src/services/config_service.dart';
import 'package:surf_flutter_starter/src/services/network_service.dart';
import 'package:surf_flutter_starter/src/services/settings_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// CLI-entry point for starting commands.
class StarterCommandRunner extends CommandRunner<int> {
  final _settingsService = SettingsService();
  final _networkService = DioService(Dio());

  /// Constructor for Runner.
  StarterCommandRunner()
      : super(
          'surf_flutter_starter',
          'CLI-tool for creating new Flutter projects, based on surf-flutter-app-template',
        ) {
    argParser.addFlag(
      'verbose',
      help: 'Print verbose output',
      abbr: 'v',
      negatable: false,
      callback: (isVerbose) {
        _settingsService.isVerbose = isVerbose;
        if (isVerbose) {
          Logger.setVerbose();
        }
      },
    );

    <Command<int>>[
      // TODO(taranov): should we implement DI system?
      CreateCommand(
        Executor(
          CloneTemplateJob(
            TemplateRepository(
              _networkService,
              _settingsService,
              ConfigService(),
            ),
          ),
        ),
      ),
    ].forEach(addCommand);
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final argResults = parse(args);

      final exitCode = await runCommand(argResults) ?? ExitCode.success.code;
      return exitCode;
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return ExitCode.usage.code;
    }
  }
}
