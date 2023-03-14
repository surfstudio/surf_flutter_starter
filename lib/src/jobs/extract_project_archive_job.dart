import 'package:surf_flutter_starter/src/jobs/configurable_job.dart';
import 'package:surf_flutter_starter/src/repositories/template_repository.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';
import 'package:surf_flutter_starter/src/utils/replace_path_separators_x.dart';

/// Extracts project folder from zip-archive.
///
/// Cleans up residual archive afterwards.
class ExtractProjectArchiveJob extends ConfigurableJob {
  final TemplateRepository _templateRepository;

  /// Constructor, in which repositories are passed.
  ExtractProjectArchiveJob(this._templateRepository);
  @override
  Future<void> execute() async {
    final archivePath =
        '${config.projectPath.value!}\\${config.projectName.value!}.zip'
            .replacePathSeparators();
    await _templateRepository.extractTemplateFromArchive(
      archiveInputPath: archivePath,
      templateOutputPath: config.projectPath.value!,
    );
    // Cleaning up after template extraction.
    try {
      _templateRepository.deleteTemplateArchive(templatePath: archivePath);
    } on Exception catch (e) {
      Logger.info(e.toString());
    }
  }
}
