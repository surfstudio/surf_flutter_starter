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

  static const _androidMainManifestPath = 'android\\app\\src\\main\\AndroidManifest.xml';
  static const _androidDebugManifestPath = 'android\\app\\src\\debug\\AndroidManifest.xml';
  static const _androidProfileManifestPath = 'android\\app\\src\\debug\\AndroidManifest.xml';
  static const _androidAppGradlePath = 'android\\app\\build.gradle';

  static const _oldPackageID = AppID.defaultPackageID;
  static const _oldAppID = AppID.defaultAppID;
  static const _oldAppLabel = AppLabel.defaultAppLabel;

  static const _oldKotlinPath = 'android\\app\\src\\main\\kotlin\\com\\example\\flutter_template\\MainActivity.kt';
  static const _oldIDPath = 'android\\app\\src\\main\\kotlin\\com\\example';

  static const _iosInfoPlistPath = 'ios\\Runner\\Info.plist';
  static const _iosCommonPath = 'ios\\Flutter\\common.xcconfig';

  /// Renames project files & contents.
  ///
  /// project\lib\...
  Future<void> renameProject({
    required String executablePath,
    required String projectName,
  }) async {
    _directoryService.updateDirectory(
      directoryPath: '$executablePath\\$templateProjectNameMain',
      newName: projectName,
    );
    final fullPath = '$executablePath\\$projectName';
    _directoryService.updateAllFiles(
      directoryPath: fullPath,
      oldValue: _oldAppLabel,
      newValue: projectName,
    );
  }

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
    final fullPath = '$executablePath\\$projectName';
    String mainManifestContent = _directoryService.readFileAsString(filePath: '$fullPath\\$_androidMainManifestPath');
    mainManifestContent = mainManifestContent.replaceAll(_oldPackageID, bundleId);
    mainManifestContent = mainManifestContent.replaceAll(_oldAppLabel, appLabel);
    _directoryService.updateFile(filePath: '$fullPath\\$_androidMainManifestPath', content: mainManifestContent);
    // Step 2. Rename Debug Manifest.
    String debugManifestContent = _directoryService.readFileAsString(filePath: '$fullPath\\$_androidDebugManifestPath');
    debugManifestContent = debugManifestContent.replaceAll(_oldPackageID, bundleId);
    _directoryService.updateFile(filePath: '$fullPath\\$_androidDebugManifestPath', content: debugManifestContent);
    // Step 3. Rename Profile Manifest.
    String profileManifestContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_androidProfileManifestPath');
    profileManifestContent = profileManifestContent.replaceAll(_oldPackageID, bundleId);
    _directoryService.updateFile(filePath: '$fullPath\\$_androidProfileManifestPath', content: profileManifestContent);
    // Step 4. Rename app\build.gradle.
    String gradleContent = _directoryService.readFileAsString(filePath: '$fullPath\\$_androidAppGradlePath');
    gradleContent = gradleContent.replaceAll(_oldAppID, bundleId);
    _directoryService.updateFile(filePath: '$fullPath\\$_androidAppGradlePath', content: gradleContent);
    // Step 5. Rename Kotlin MainActivity file.
    String kotlinContent = _directoryService.readFileAsString(filePath: '$fullPath\\$_oldKotlinPath');
    kotlinContent = kotlinContent.replaceAll(_oldPackageID, bundleId);

    final newKotlinPath = '$fullPath\\android\\app\\src\\main\\kotlin\\${_getPathFromBundle(bundleId)}';
    await _directoryService.createFile(filePath: newKotlinPath, fileName: 'MainActivity.kt', isRecursive: true);
    String newKotlinContent = _directoryService.readFileAsString(filePath: '$newKotlinPath\\MainActivity.kt');
    newKotlinContent = kotlinContent;
    _directoryService.updateFile(filePath: '$newKotlinPath\\MainActivity.kt', content: newKotlinContent);
    // Step 6. Delete remaining directory.
    _directoryService.deleteDirectory(directoryPath: '$fullPath\\$_oldIDPath');

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
    final fullPath = '$executablePath\\$projectName';
    // Step 1. Rename Info.plist
    String infoPlistContent = _directoryService.readFileAsString(filePath: '$fullPath\\$_iosInfoPlistPath');
    infoPlistContent = infoPlistContent.replaceAll(_oldPackageID, bundleId);
    infoPlistContent = infoPlistContent.replaceAll(_oldAppLabel, appLabel);
    _directoryService.updateFile(filePath: '$fullPath\\$_iosInfoPlistPath', content: infoPlistContent);
    // Step 2. Rename common.xcconfig
    String infoConfigContent = _directoryService.readFileAsString(filePath: '$fullPath\\$_iosCommonPath');
    infoConfigContent = infoConfigContent.replaceAll(_oldAppID, bundleId);
    _directoryService.updateFile(filePath: '$fullPath\\$_iosCommonPath', content: infoConfigContent);

    Logger.fine('iOS renaming complete!');
  }

  String _getPathFromBundle(String bundleId) {
    return bundleId.replaceAll('.', '\\');
  }
}
