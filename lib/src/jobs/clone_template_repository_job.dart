import 'package:surf_flutter_starter/exceptions.dart';
import 'package:surf_flutter_starter/src/jobs/i_job.dart';
import 'package:surf_flutter_starter/src/services/git_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

class CloneTemplateRepositoryJob extends IJob {
  final GitService _gitService;

  CloneTemplateRepositoryJob(this._gitService);

  @override
  Future<void> execute() async {
    try {
      final result = await _gitService.cloneTemplateRepository();
      return result;
    } on GitException catch (e) {
      logger.stderr(e.message);
      throw JobException(e.toString());
    } on Exception catch (e) {
      logger.stderr(e.toString());
      throw JobException(e.toString());
    }
  }
}
