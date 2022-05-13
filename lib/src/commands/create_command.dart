import 'package:io/io.dart';
import 'package:surf_flutter_starter/src/commands/base_command.dart';
import 'package:surf_flutter_starter/src/creators/automatic_creator.dart';
import 'package:surf_flutter_starter/src/creators/creator.dart';
import 'package:surf_flutter_starter/src/creators/interactive_cli_creator.dart';

/// Creates new project.
///
/// Project creation is, essentially, run of [Creator]'s [Creator.start].
/// If it completes normally, [CreateCommand.run] method returns success code.
///
/// Returns [ExitCode.usage] - otherwise.
class CreateCommand extends BaseCommand {
  final InteractiveCLICreator _interactiveCLICreator;
  final AutomaticCreator _automaticCreator;

  @override
  String get description => 'Creates new Flutter project based on Surf project template';

  @override
  String get name => 'create';

  /// Constructor, in which [Creator]s are passed.
  CreateCommand(
    this._interactiveCLICreator,
    this._automaticCreator,
  ) {
    argParser.addOption(
      'config-path',
      help: 'Specify where config.json file is located.',
      abbr: 'c',
    );
  }

  @override
  Future<int> run() async {
    final hasConfigPath = argResults?['config-path'] != null && (argResults!['config-path'] as String).isNotEmpty;
    if (hasConfigPath) {
      await _automaticCreator.start();
    } else {
      await _interactiveCLICreator.start();
    }
    return ExitCode.success.code;
  }
}
