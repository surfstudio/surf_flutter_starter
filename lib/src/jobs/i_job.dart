import 'package:surf_flutter_starter/exceptions.dart';

// ignore: one_member_abstracts
abstract class IJob {
  /// Executes specific task for project template creation
  ///
  /// Returns 'void'
  ///
  /// May throw [JobException]
  Future<void> execute();
}
