import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/jobs/configurable_job.dart';
import 'package:surf_flutter_starter/src/repositories/template_repository.dart';

/// Renames all project files and content according to [Config].
///
/// All [ConfigParameter]s are taken into consideration, so that all that can
/// be changed about initial project template, will be changed.
class RenameProjectJob extends ConfigurableJob {
  final TemplateRepository _templateRepository;

  /// Constructor, in which repositories are passed.
  RenameProjectJob(this._templateRepository);

  @override
  Future<void> execute() async {
    await _templateRepository.renameProject(
      templatePath: config.projectPath.value!,
      projectName: config.projectName.value!,
      bundleId: config.appID.value!,
      isAndroidSupport: Config.defaultAndroidSupport,
      isIOSSupport: Config.defaultIOSSupport,
      isMacOSSupport: Config.defaultMacOSSupport,
      isLinuxSupport: Config.defaultLinuxSupport,
    );
  }
}
