import 'dart:io';

import 'package:surf_flutter_starter/src/runner.dart';

Future<void> main(Iterable<String> args) async {
  exit(await StarterCommandRunner().run(args));
}
