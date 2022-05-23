import 'package:surf_flutter_starter/src/services/archive_service.dart';
import 'package:surf_flutter_starter/src/services/directory_service.dart';
import 'package:surf_flutter_starter/src/services/network_service.dart';
import 'package:surf_flutter_starter/src/services/renaming_service.dart';

/// Repository for managing basic project template.
class TemplateRepository {
  final NetworkService _networkService;
  final ArchiveService _archiveService;
  final DirectoryService _directoryService;
  final RenamingService _renamingService;

  /// Constructor, in which services are passed.
  const TemplateRepository(
    this._networkService,
    this._archiveService,
    this._directoryService,
    this._renamingService,
  );

  /// Gets project template from [templateUrl] & saves it to [savingPath].
  ///
  /// Downloads template as zip-archive, using [NetworkService.download].
  Future<void> fetchTemplateToDirectory({
    required String templateUrl,
    required String savingPath,
    required String templateName,
  }) async {
    await _networkService.download(
      url: templateUrl,
      path: '$savingPath\\$templateName.zip',
    );
  }

  /// Extracts project template from [archiveInputPath] to [templateOutputPath].
  ///
  /// Extracts archive via [ArchiveService.extractArchive].
  Future<void> extractTemplateFromArchive({
    required String archiveInputPath,
    required String templateOutputPath,
  }) async {
    await _archiveService.extractArchive(
      inputPath: archiveInputPath,
      outputPath: templateOutputPath,
    );
  }

  /// Deletes template archive from Disc.
  void deleteTemplateArchive({
    required String templatePath,
  }) {
    _directoryService.deleteFile(filePath: templatePath);
  }

  /// Renames project template file & contents.
  ///
  /// Using [RenamingService].
  Future<void> renameProject({
    required String templatePath,
    required String projectName,
    required String appLabel,
    required String bundleId,
    required bool isAndroidSupport,
    required bool isIOSSupport,
    required bool isMacOSSupport,
    required bool isLinuxSupport,
  }) async {
    if (isAndroidSupport) {
      await _renamingService.renameAndroid(
        executablePath: templatePath,
        projectName: projectName,
        appLabel: appLabel,
        bundleId: bundleId,
      );
    }
    if (isIOSSupport) {
      await _renamingService.renameIOS(
        executablePath: templatePath,
        projectName: projectName,
        appLabel: appLabel,
        bundleId: bundleId,
      );
    }
  }
}
