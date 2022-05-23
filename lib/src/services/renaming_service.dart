import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/services/directory_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

import '../constants.dart';

/// Renames project files & content.
///
/// Runs [https://pub.dev/packages/rename] to do so.
class RenamingService {
  final DirectoryService _directoryService;

  /// Constructor, in which [DirectoryService] is passed.
  const RenamingService(this._directoryService);

  static const _androidMainManifestPath = '$templateProjectNameMain\\android\\app\\src\\main\\AndroidManifest.xml';
  static const _androidDebugManifestPath = '$templateProjectNameMain\\android\\app\\src\\debug\\AndroidManifest.xml';
  static const _androidProfileManifestPath = '$templateProjectNameMain\\android\\app\\src\\debug\\AndroidManifest.xml';
  static const _androidAppGradlePath = '$templateProjectNameMain\\android\\app\\build.gradle';

  static const _oldPackageID = AppID.defaultPackageID;
  static const _oldAppID = AppID.defaultAppID;
  static const _oldAppLabel = AppLabel.defaultAppLabel;

  static const _oldKotlinPath =
      '$templateProjectNameMain\\android\\app\\src\\main\\kotlin\\com\\example\\flutter_template\\MainActivity.kt';

  static const _iosInfoPlistPath = '$templateProjectNameMain\\ios\\Runner\\Info.plist';

  /// Renames all android-specific files & contents.
  ///
  /// project\android\...
  Future<void> renameAndroid({
    required String executablePath,
    required String projectName,
    required String appLabel,
    required String bundleId,
  }) async {
    // Step 1. Rename Main Manifest.
    String mainManifestContent =
        _directoryService.readFileAsString(filePath: '$executablePath\\$_androidMainManifestPath');
    mainManifestContent = mainManifestContent.replaceAll(_oldPackageID, bundleId);
    mainManifestContent = mainManifestContent.replaceAll(_oldAppLabel, appLabel);
    _directoryService.updateFile(filePath: '$executablePath\\$_androidMainManifestPath', content: mainManifestContent);
    // Step 2. Rename Debug Manifest.
    String debugManifestContent =
        _directoryService.readFileAsString(filePath: '$executablePath\\$_androidDebugManifestPath');
    debugManifestContent = debugManifestContent.replaceAll(_oldPackageID, bundleId);
    _directoryService.updateFile(
        filePath: '$executablePath\\$_androidDebugManifestPath', content: debugManifestContent);
    // Step 3. Rename Profile Manifest.
    String profileManifestContent =
        _directoryService.readFileAsString(filePath: '$executablePath\\$_androidProfileManifestPath');
    profileManifestContent = profileManifestContent.replaceAll(_oldPackageID, bundleId);
    _directoryService.updateFile(
        filePath: '$executablePath\\$_androidProfileManifestPath', content: profileManifestContent);
    // Step 4. Rename app\build.gradle.
    String gradleContent = _directoryService.readFileAsString(filePath: '$executablePath\\$_androidAppGradlePath');
    gradleContent = gradleContent.replaceAll(_oldAppID, bundleId);
    _directoryService.updateFile(filePath: '$executablePath\\$_androidAppGradlePath', content: gradleContent);
    // Step 5. Rename Kotlin MainActivity file.
    String kotlinContent = _directoryService.readFileAsString(filePath: '$executablePath\\$_oldKotlinPath');
    kotlinContent = kotlinContent.replaceAll(_oldPackageID, bundleId);

    final newKotlinPath =
        '$executablePath\\$templateProjectNameMain\\android\\app\\src\\main\\kotlin\\${_getPathFromBundle(bundleId)}';
    await _directoryService.createFile(filePath: newKotlinPath, fileName: 'MainActivity.kt', isRecursive: true);
    String newKotlinContent = _directoryService.readFileAsString(filePath: '$newKotlinPath\\MainActivity.kt');
    newKotlinContent = kotlinContent;
    _directoryService.updateFile(filePath: '$newKotlinPath\\MainActivity.kt', content: newKotlinContent);

    Logger.fine('Android renaming complete!');
  }

  /// Renames all iOS-specific files & contents.
  ///
  /// project\ios\...
  Future<void> renameIOS({
    required String executablePath,
    required String projectName,
    required String appLabel,
    required String bundleId,
  }) async {
    String infoPlistContent = _directoryService.readFileAsString(filePath: '$executablePath\\$_iosInfoPlistPath');
    infoPlistContent = infoPlistContent.replaceAll(_oldPackageID, bundleId);
    infoPlistContent = infoPlistContent.replaceAll(_oldAppLabel, appLabel);
    _directoryService.updateFile(filePath: '$executablePath\\$_iosInfoPlistPath', content: infoPlistContent);
  }

  String _getPathFromBundle(String bundleId) {
    return bundleId.replaceAll('.', '\\');
  }
}
