import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/services/archive_service.dart';
import 'package:surf_flutter_starter/src/services/directory_service.dart';
import 'package:surf_flutter_starter/src/services/network_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Repository for managing basic project template.
class TemplateRepository {
  final NetworkService _networkService;
  final ArchiveService _archiveService;
  final DirectoryService _directoryService;

  /// Constructor, in which services are passed.
  const TemplateRepository(
    this._networkService,
    this._archiveService,
    this._directoryService,
  );

  /// Gets project template from [templateUrl] & saves it to [savingPath].
  ///
  /// Downloads template as zip-archive, using [NetworkService.download].
  ///
  /// May throw [RepositoryException].
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
      logger.stderr(e.message);
      throw RepositoryException(e.message);
    }
  }

  /// Extracts project template from [archiveInputPath] to [templateOutputPath].
  ///
  /// Extracts archive via [ArchiveService.extractArchive].
  ///
  /// May throw [RepositoryException].
  Future<void> extractTemplateFromArchive({
    required String archiveInputPath,
    required String templateOutputPath,
  }) async {
    try {
      await _archiveService.extractArchive(
        inputPath: archiveInputPath,
        outputPath: templateOutputPath,
      );
    } on FileSystemException catch (e) {
      logger.stderr(e.message);
      throw RepositoryException(e.message);
    }
  }

  /// Deletes template archive from Disc
  ///
  /// May throw [RepositoryException].
  void deleteTemplateArchive({
    required String templatePath,
  }) {
    _directoryService.deleteFile(filePath: templatePath);
  }
}
