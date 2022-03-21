import 'package:surf_flutter_starter/exceptions.dart';

/// [Job] - is an atomic task, which does something and returns 'void' on completion.
///
/// Job's are used for project generation process. They are top-level entities,
/// which define several technical steps of creating new project. [Job]'s are
/// expandable. Meaning, that series of more [Job]'s can create more complex
/// structure.
// ignore: one_member_abstracts
abstract class Job {
  /// Executes specific task for project template creation
  ///
  /// Returns 'void'
  ///
  /// May throw [JobException]
  Future<void> execute();
}
