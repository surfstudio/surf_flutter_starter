import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/services/network_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Repository for managing basic project template.
class TemplateRepository {
  final NetworkService _networkService;

  /// Constructor, in which services are passed.
  const TemplateRepository(
    this._networkService,
  );

  /// Gets project [templateUrl] & saves it to [savingPath].
  ///
  /// Downloads template as zip-archive, using [NetworkService.download].
  Future<void> fetchTemplateToDirectory({
    required String templateUrl,
    required String savingPath,
    required String templateName,
  }) async {
    try {
      await _networkService.download(
        url: templateUrl,
        path: '$savingPath\\$templateName.zip',
      );
    } on NetworkException catch (e) {
      logger.stderr(e.toString());
      throw RepositoryException(e.toString());
    }
  }
}
