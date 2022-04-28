import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/jobs/configurable_job.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/repositories/template_repository.dart';

/// [Job] for cloning project template.
class CloneTemplateJob extends ConfigurableJob {
  final TemplateRepository _templateRepository;

  /// Constructor, in which repositories are passed.
  CloneTemplateJob(this._templateRepository);

  @override
  Future<void> execute() async {
    final result = await _templateRepository.fetchTemplateToDirectory(
      templateName: config.projectName.value!,
      savingPath: config.projectPath.value!,
      templateUrl: Config.templateUrl,
    );
    return result;
  }
}
