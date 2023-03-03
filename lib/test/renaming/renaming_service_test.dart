import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/services/directory_service.dart';
import 'package:surf_flutter_starter/src/services/renaming_service.dart';
import 'package:surf_flutter_starter/src/utils/replace_path_separators_x.dart';
import 'package:surf_flutter_starter/test/renaming/res/android_gradle_res.dart';
import 'package:surf_flutter_starter/test/renaming/res/common_file.dart';
import 'package:surf_flutter_starter/test/renaming/res/debug_android_manifest.dart';
import 'package:surf_flutter_starter/test/renaming/res/main_activity.dart';
import 'package:surf_flutter_starter/test/renaming/res/main_android_manifest.dart';
import 'package:surf_flutter_starter/test/renaming/res/plist.dart';
import 'package:surf_flutter_starter/test/renaming/res/profile_android_manifest.dart';
import 'package:surf_flutter_starter/test/renaming/res/test_res.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock for [IODirectoryService]
class DirectoryServiceMock extends Mock implements DirectoryService {}

void main() {
  late final RenamingService renamingService;
  final DirectoryService directoryService = DirectoryServiceMock();

  final mainManifestPath =
      '$testExePath\\$projectName\\${ProjectPath.androidMainManifestPath}'.replacePathSeparators();
  final debugManifestPath =
      '$testExePath\\$projectName\\${ProjectPath.androidDebugManifestPath}'.replacePathSeparators();
  final profileManifestPath =
      '$testExePath\\$projectName\\${ProjectPath.androidProfileManifestPath}'
          .replacePathSeparators();
  final gradlePath =
      '$testExePath\\$projectName\\${ProjectPath.androidAppGradlePath}'.replacePathSeparators();
  final kotlinPath =
      '$testExePath\\$projectName\\${ProjectPath.oldKotlinPath}'.replacePathSeparators();
  final activityPath =
      '$testExePath\\$projectName\\android\\app\\src\\main\\kotlin\\com\\test\\app\\MainActivity.kt'
          .replacePathSeparators();
  final commonPath =
      '$testExePath\\$projectName\\${ProjectPath.iosCommonPath}'.replacePathSeparators();
  final plistPath =
      '$testExePath\\$projectName\\${ProjectPath.iosInfoPlistPath}'.replacePathSeparators();

  setUpAll(() {
    /// Set up for android renaming
    when(() => directoryService.readFileAsString(filePath: mainManifestPath))
        .thenReturn(mainManifestTest);
    when(() =>
            directoryService.updateFile(filePath: mainManifestPath, content: renamedMainManifest))
        .thenReturn(() {});

    when(() => directoryService.readFileAsString(filePath: debugManifestPath))
        .thenReturn(debugManifestTest);
    when(() => directoryService.updateFile(
        filePath: debugManifestPath, content: renamedDebugManifestTest)).thenReturn(() {});

    when(() => directoryService.readFileAsString(filePath: profileManifestPath))
        .thenReturn(profileManifestTest);
    when(() => directoryService.updateFile(
        filePath: profileManifestPath, content: renamedProfileManifestTest)).thenReturn(() {});

    when(() => directoryService.readFileAsString(filePath: gradlePath)).thenReturn(gradleTest);
    when(() => directoryService.updateFile(filePath: gradlePath, content: editedGradleTest))
        .thenReturn(() {});

    when(() => directoryService.readFileAsString(filePath: kotlinPath)).thenReturn(activity);
    when(() => directoryService.createFile(
        filePath: '$testExePath\\$projectName\\android\\app\\src\\main\\kotlin\\com\\test\\app'
            .replacePathSeparators(),
        fileName: 'MainActivity.kt',
        isRecursive: true)).thenAnswer((_) async {});
    when(() => directoryService.readFileAsString(filePath: activityPath)).thenReturn(activity);
    when(() => directoryService.updateFile(filePath: activityPath, content: editedActivity))
        .thenReturn(() {});
    when(() => directoryService.deleteDirectory(directoryPath: kotlinPath)).thenReturn(() {});

    /// Set up for IOS renaming
    when(() => directoryService.readFileAsString(filePath: plistPath)).thenReturn(plist);
    when(() => directoryService.updateFile(filePath: plistPath, content: editedPlist))
        .thenReturn(() {});
    when(() => directoryService.readFileAsString(filePath: commonPath)).thenReturn(commonFile);
    when(() => directoryService.updateFile(filePath: commonPath, content: editedCommonFile))
        .thenReturn(() {});

    renamingService = RenamingService(directoryService);
  });

  test('rename Android', () async {
    await renamingService.renameAndroid(
        executablePath: testExePath,
        projectName: projectName,
        appLabel: appLabel,
        bundleId: bundleId);

    verify(() =>
        directoryService.updateFile(filePath: mainManifestPath, content: renamedMainManifest));
    verify(() => directoryService.updateFile(
        filePath: debugManifestPath, content: renamedDebugManifestTest));
    verify(() => directoryService.updateFile(
        filePath: profileManifestPath, content: renamedProfileManifestTest));
    verify(() => directoryService.updateFile(filePath: gradlePath, content: editedGradleTest));
    verify(() => directoryService.updateFile(filePath: activityPath, content: editedActivity));
  });

  test('rename IOS', () async {
    await renamingService.renameIOS(
        executablePath: testExePath,
        projectName: projectName,
        appLabel: appLabel,
        bundleId: bundleId);

    verify(() => directoryService.updateFile(filePath: plistPath, content: editedPlist));
    verify(() => directoryService.updateFile(filePath: commonPath, content: editedCommonFile));
  });
}
