import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';
import 'package:surf_flutter_starter/src/repositories/template_repository.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// [Job] for cloning project template.
class CloneTemplateJob implements Job {
  final TemplateRepository _templateRepository;

  /// Constructor, in which repositories are passed.
  const CloneTemplateJob(this._templateRepository);

  @override
  Future<void> execute() async {
    try {
      final result = await _templateRepository.getTemplate();
      return result;
    } on Exception catch (e) {
      logger.stderr(e.toString());
      throw JobException(e.toString());
    }
  }
}
