import 'package:meta/meta.dart';
import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';

/// Interface for Project creation.
abstract class Creator {
  /// Main [Creator] entry-point.
  Future<void> start() async {
    final config = await prepareConfig();
    return createByConfig(config);
  }

  /// Retrieves [Config] from somewhere.
  @protected
  Future<Config> prepareConfig();

  /// Creates Project by given [Config].
  ///
  /// Runs series of [Job]s to do so.
  @protected
  Future<void> createByConfig(Config config);
}
