import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';

/// [Job] requires [Config], as project-describing entity.
abstract class ConfigurableJob extends Job {
  /// Instance of [Config].
  ///
  /// Holds [Job]-specific instance of [Config], required for
  /// [Job.execute] & project creation process.
  late final Config config;

  /// Sets up [Job] before its' [Job.execute].
  ///
  /// Requires [Config].
  void setupJob(Config config) {
    this.config = config;
  }
}
