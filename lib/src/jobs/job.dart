import 'package:surf_flutter_starter/src/exceptions.dart';

/// Atomic task, which does something and returns `Object?` on completion.
///
/// [Job]'s are used for project generation process. They are top-level entities,
/// which define several technical steps of creating new project. [Job]'s are
/// expandable. Meaning, that series of more [Job]'s can create more complex
/// structure.
abstract class Job {
  /// Executes specific task for project template creation.
  ///
  /// Returns `Object?`
  ///
  /// May throw [JobException].
  Future<Object?> execute();
}
