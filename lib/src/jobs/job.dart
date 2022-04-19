// ignore_for_file: one_member_abstracts
import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';

/// Atomic task, which does something and returns `Object?` on completion.
///
/// [Job]'s are used for project generation process. They are top-level entities,
/// which define several technical steps of creating new project. [Job]'s are
/// expandable. Meaning, that series of more [Job]'s can create more complex
/// structure.
///
/// [Job] requires [Config], as project-describing entity in [Job.execute].
abstract class Job {
  /// Executes specific task for project template creation.
  ///
  /// Requires [Config].
  /// Returns 'Object?'
  ///
  /// May throw [JobException]
  Future<Object?> execute(Config config);
}
