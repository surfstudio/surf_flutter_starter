import 'package:args/command_runner.dart';

/// Base Command
abstract class BaseCommand extends Command<int> {
  @override
  String get invocation => 'surf_flutter_starter $name';
}
