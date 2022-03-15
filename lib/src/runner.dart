import 'package:args/command_runner.dart';
import 'package:io/io.dart';
import 'package:surf_flutter_starter/src/commands/create_command.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_repository_job.dart';
import 'package:surf_flutter_starter/src/services/git_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

class StarterCommandRunner extends CommandRunner<int> {
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

    <Command<int>>[
      // TODO(taranov): should we implement DI system?
      CreateCommand(CloneTemplateRepositoryJob(GitService())),
    ].forEach(addCommand);
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final _argResults = parse(args);

      final exitCode = await runCommand(_argResults) ?? ExitCode.success.code;
      return exitCode;
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return ExitCode.usage.code;
    }
  }
}
