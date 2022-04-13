import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:io/io.dart';
import 'package:surf_flutter_starter/src/commands/create_command.dart';
import 'package:surf_flutter_starter/src/config/config_builder.dart';
import 'package:surf_flutter_starter/src/creators/automatic_creator.dart';
import 'package:surf_flutter_starter/src/creators/interactive_cli_creator.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_job.dart';
import 'package:surf_flutter_starter/src/jobs/get_config_cli_job.dart';
import 'package:surf_flutter_starter/src/repositories/config_repository.dart';
import 'package:surf_flutter_starter/src/repositories/template_repository.dart';
import 'package:surf_flutter_starter/src/services/config_service.dart';
import 'package:surf_flutter_starter/src/services/dialog_service.dart';
import 'package:surf_flutter_starter/src/services/network_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';
import 'package:surf_flutter_starter/src/utils/terminal.dart';

/// CLI-entry point for starting commands.
class StarterCommandRunner extends CommandRunner<int> {
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
        if (isVerbose) {
          Logger.setVerbose();
        }
      },
    );
    // TODO(taranov): should we implement DI system?
    // Services:
    final _networkService = DioService(Dio());
    final _configService = ConfigService(MinimalConfigBuilder());

    // Repositories:
    final _configRepository = ConfigRepository(
      TerminalDialogService(
        Terminal(),
      ),
      _configService,
    );
    final _templateRepository = TemplateRepository(_networkService, _configService);

    // Jobs:
    final _getConfigCLIJob = GetConfigCLIJob(_configRepository);
    final _cloneTemplateJob = CloneTemplateJob(_templateRepository);
    <Command<int>>[
      CreateCommand(
        InteractiveCLICreator(
          _getConfigCLIJob,
          _cloneTemplateJob,
          _configService,
        ),
        AutomaticCreator(),
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
