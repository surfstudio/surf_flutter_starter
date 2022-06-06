import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/services/directory_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';
import 'package:surf_flutter_starter/src/utils/replace_path_separators_x.dart';

import '../constants.dart';

/// Renames project files & content.
///
/// Runs [https://pub.dev/packages/rename] to do so.
class RenamingService {
  final DirectoryService _directoryService;

  /// Constructor, in which [DirectoryService] is passed.
  RenamingService(this._directoryService);

  final _androidMainManifestPath = 'android\\app\\src\\main\\AndroidManifest.xml'.replacePathSeparators();
  final _androidDebugManifestPath = 'android\\app\\src\\debug\\AndroidManifest.xml'.replacePathSeparators();
  final _androidProfileManifestPath = 'android\\app\\src\\debug\\AndroidManifest.xml'.replacePathSeparators();
  final _androidAppGradlePath = 'android\\app\\build.gradle';

  final _oldPackageID = AppID.defaultPackageID;
  final _oldAppID = AppID.defaultAppID;
  final _oldAppLabel = AppLabel.defaultAppLabel;

  final _oldKotlinPath =
      'android\\app\\src\\main\\kotlin\\com\\example\\flutter_template\\MainActivity.kt'.replacePathSeparators();
  final _oldIDPath = 'android\\app\\src\\main\\kotlin\\com\\example'.replacePathSeparators();

  final _iosInfoPlistPath = 'ios\\Runner\\Info.plist'.replacePathSeparators();
  final _iosCommonPath = 'ios\\Flutter\\common.xcconfig'.replacePathSeparators();

  /// Renames project files & contents.
  ///
  /// project\lib\...
  Future<void> renameProject({
    required String executablePath,
    required String projectName,
  }) async {
    _directoryService.updateDirectory(
      directoryPath: '$executablePath\\$templateProjectNameMain'.replacePathSeparators(),
      newName: projectName,
    );
    final fullPath = '$executablePath\\$projectName'.replacePathSeparators();
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
    final fullPath = '$executablePath\\$projectName'.replacePathSeparators();
    String mainManifestContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_androidMainManifestPath'.replacePathSeparators());
    mainManifestContent = mainManifestContent.replaceAll(_oldPackageID, bundleId);
    mainManifestContent = mainManifestContent.replaceAll(_oldAppLabel, appLabel);
    _directoryService.updateFile(
        filePath: '$fullPath\\$_androidMainManifestPath'.replacePathSeparators(), content: mainManifestContent);
    // Step 2. Rename Debug Manifest.
    String debugManifestContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_androidDebugManifestPath'.replacePathSeparators());
    debugManifestContent = debugManifestContent.replaceAll(_oldPackageID, bundleId);
    _directoryService.updateFile(
        filePath: '$fullPath\\$_androidDebugManifestPath'.replacePathSeparators(), content: debugManifestContent);
    // Step 3. Rename Profile Manifest.
    String profileManifestContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_androidProfileManifestPath'.replacePathSeparators());
    profileManifestContent = profileManifestContent.replaceAll(_oldPackageID, bundleId);
    _directoryService.updateFile(
        filePath: '$fullPath\\$_androidProfileManifestPath'.replacePathSeparators(), content: profileManifestContent);
    // Step 4. Rename app\build.gradle.
    String gradleContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_androidAppGradlePath'.replacePathSeparators());
    gradleContent = gradleContent.replaceAll(_oldAppID, bundleId);
    _directoryService.updateFile(
        filePath: '$fullPath\\$_androidAppGradlePath'.replacePathSeparators(), content: gradleContent);
    // Step 5. Rename Kotlin MainActivity file.
    String kotlinContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_oldKotlinPath'.replacePathSeparators());
    kotlinContent = kotlinContent.replaceAll(_oldPackageID, bundleId);

    final newKotlinPath =
        '$fullPath\\android\\app\\src\\main\\kotlin\\${_getPathFromBundle(bundleId)}'.replacePathSeparators();
    await _directoryService.createFile(filePath: newKotlinPath, fileName: 'MainActivity.kt', isRecursive: true);
    String newKotlinContent =
        _directoryService.readFileAsString(filePath: '$newKotlinPath\\MainActivity.kt'.replacePathSeparators());
    newKotlinContent = kotlinContent;
    _directoryService.updateFile(
        filePath: '$newKotlinPath\\MainActivity.kt'.replacePathSeparators(), content: newKotlinContent);
    // Step 6. Delete remaining directory.
    _directoryService.deleteDirectory(directoryPath: '$fullPath\\$_oldIDPath'.replacePathSeparators());

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
    final fullPath = '$executablePath\\$projectName'.replacePathSeparators();
    // Step 1. Rename Info.plist
    String infoPlistContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_iosInfoPlistPath'.replacePathSeparators());
    infoPlistContent = infoPlistContent.replaceAll(_oldPackageID, bundleId);
    infoPlistContent = infoPlistContent.replaceAll(_oldAppLabel, appLabel);
    _directoryService.updateFile(
        filePath: '$fullPath\\$_iosInfoPlistPath'.replacePathSeparators(), content: infoPlistContent);
    // Step 2. Rename common.xcconfig
    String infoConfigContent =
        _directoryService.readFileAsString(filePath: '$fullPath\\$_iosCommonPath'.replacePathSeparators());
    infoConfigContent = infoConfigContent.replaceAll(_oldAppID, bundleId);
    _directoryService.updateFile(
        filePath: '$fullPath\\$_iosCommonPath'.replacePathSeparators(), content: infoConfigContent);

    Logger.fine('iOS renaming complete!');
  }

  String _getPathFromBundle(String bundleId) {
    return bundleId.replaceAll('.', '\\'.replacePathSeparators());
  }
}
