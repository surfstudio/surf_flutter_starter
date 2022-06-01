import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/creators/creator.dart';
import 'package:surf_flutter_starter/src/jobs/clone_template_job.dart';
import 'package:surf_flutter_starter/src/jobs/extract_project_archive_job.dart';
import 'package:surf_flutter_starter/src/jobs/get_config_cli_job.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/jobs/rename_project_job.dart';

/// Creates Project via CLI interaction.
class InteractiveCLICreator extends Creator {
  final GetConfigCLIJob _getConfigCLIJob;
  final CloneTemplateJob _cloneTemplateJob;
  final ExtractProjectArchiveJob _extractProjectArchiveJob;
  final RenameProjectJob _renameProjectJob;

  /// Constructor, in which [Job]s are passed.
  InteractiveCLICreator(
    this._getConfigCLIJob,
    this._cloneTemplateJob,
    this._extractProjectArchiveJob,
    this._renameProjectJob,
  );

  @override
  Future<Config> prepareConfig() async {
    final config = await _getConfigCLIJob.execute();
    return config;
  }

  @override
  Future<void> createByConfig(Config config) async {
    // Run series of jobs.
    _cloneTemplateJob.setupJob(config);
    await _cloneTemplateJob.execute();

    _extractProjectArchiveJob.setupJob(config);
    await _extractProjectArchiveJob.execute();

    _renameProjectJob.setupJob(config);
    await _renameProjectJob.execute();
  }
}
