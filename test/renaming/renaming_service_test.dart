import 'package:surf_flutter_starter/src/config/config_parameter.dart';
import 'package:surf_flutter_starter/src/constants.dart';
import 'package:surf_flutter_starter/src/services/directory_service.dart';
import 'package:surf_flutter_starter/src/services/renaming_service.dart';
import 'package:surf_flutter_starter/src/utils/replace_path_separators_x.dart';
import 'res/android_gradle_res.dart';
import 'res/common_file.dart';
import 'res/debug_android_manifest.dart';
import 'res/main_activity.dart';
import 'res/main_android_manifest.dart';

import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'res/plist.dart';
import 'res/profile_android_manifest.dart';
import 'res/test_res.dart';

/// Mock for [IODirectoryService]
class DirectoryServiceMock extends Mock implements DirectoryService {}

void main() {
  late final RenamingService renamingService;
  late final DirectoryService directoryService;

  final mainManifestPath =
      '$testExePath\\$projectName\\${ProjectPath.androidMainManifestPath}'
          .replacePathSeparators();
  final debugManifestPath =
      '$testExePath\\$projectName\\${ProjectPath.androidDebugManifestPath}'
          .replacePathSeparators();
  final profileManifestPath =
      '$testExePath\\$projectName\\${ProjectPath.androidProfileManifestPath}'
          .replacePathSeparators();
  final gradlePath =
      '$testExePath\\$projectName\\${ProjectPath.androidAppGradlePath}'
          .replacePathSeparators();
  final kotlinPath = '$testExePath\\$projectName\\${ProjectPath.oldKotlinPath}'
      .replacePathSeparators();
  final activityPath =
      '$testExePath\\$projectName\\android\\app\\src\\main\\kotlin\\com\\test\\app\\MainActivity.kt'
          .replacePathSeparators();
  final commonPath = '$testExePath\\$projectName\\${ProjectPath.iosCommonPath}'
      .replacePathSeparators();
  final plistPath =
      '$testExePath\\$projectName\\${ProjectPath.iosInfoPlistPath}'
          .replacePathSeparators();

  setUpAll(() {
    directoryService = DirectoryServiceMock();
    renamingService = RenamingService(directoryService);
  });

  /// Wrap [when] for reuse
  void whenRenameFile({
    required String path,
    required String oldFile,
    required String newFile,
  }) {
    when(() => directoryService.readFileAsString(filePath: path))
        .thenReturn(oldFile);
    when(() => directoryService.updateFile(
          filePath: path,
          content: newFile,
        )).thenReturn(() {});
  }

  /// Wrap [verify] for reuse
  void verifyRenaming({required String path, required String result}) {
    verify(() => directoryService.updateFile(
          filePath: path,
          content: result,
        ));
  }

  group('renameProject', () {
    test('should rename project directory and files', () async {
      when(() => directoryService.updateDirectory(
            directoryPath: '$testExePath\\$projectName'.replacePathSeparators(),
            newName: projectName,
          )).thenAnswer((_) {});
      when(() => directoryService.updateAllFiles(
            directoryPath: '$testExePath\\$projectName'.replacePathSeparators(),
            oldValue: AppLabel.defaultAppLabel,
            newValue: projectName,
          )).thenAnswer((_) {});

      await renamingService.renameProject(
        executablePath: testExePath,
        projectName: projectName,
      );

      verify(() => directoryService.updateDirectory(
            directoryPath: '$testExePath\\$templateProjectNameMain'
                .replacePathSeparators(),
            newName: projectName,
          ));
      verify(() => directoryService.updateAllFiles(
            directoryPath: '$testExePath\\$projectName'.replacePathSeparators(),
            oldValue: AppLabel.defaultAppLabel,
            newValue: projectName,
          ));
    });
  });

  group('rename Android', () {
    test('should rename android-specific files and contents', () async {
      /// Rename Android
      whenRenameFile(
        path: mainManifestPath,
        oldFile: mainManifestTest,
        newFile: renamedMainManifest,
      );
      whenRenameFile(
        path: debugManifestPath,
        oldFile: debugManifestTest,
        newFile: renamedDebugManifestTest,
      );
      whenRenameFile(
        path: profileManifestPath,
        oldFile: profileManifestTest,
        newFile: renamedProfileManifestTest,
      );
      whenRenameFile(
        path: gradlePath,
        oldFile: gradleTest,
        newFile: editedGradleTest,
      );

      when(() => directoryService.readFileAsString(filePath: kotlinPath))
          .thenReturn(activity);
      when(() => directoryService.createFile(
            filePath:
                '$testExePath\\$projectName\\android\\app\\src\\main\\kotlin\\com\\test\\app'
                    .replacePathSeparators(),
            fileName: 'MainActivity.kt',
            isRecursive: true,
          )).thenAnswer((_) async {});

      whenRenameFile(
        path: activityPath,
        oldFile: activity,
        newFile: editedActivity,
      );
      when(() => directoryService.deleteDirectory(directoryPath: kotlinPath))
          .thenReturn(() {});

      await renamingService.renameAndroid(
        executablePath: testExePath,
        projectName: projectName,
        appLabel: appLabel,
        bundleId: bundleId,
      );

      verifyRenaming(path: mainManifestPath, result: renamedMainManifest);
      verifyRenaming(path: debugManifestPath, result: renamedDebugManifestTest);
      verifyRenaming(
        path: profileManifestPath,
        result: renamedProfileManifestTest,
      );
      verifyRenaming(path: gradlePath, result: editedGradleTest);
      verifyRenaming(path: activityPath, result: editedActivity);
    });
  });

  group('rename IOS', () {
    test('should rename ios files and contents', () async {
      whenRenameFile(path: plistPath, oldFile: plist, newFile: editedPlist);
      whenRenameFile(
        path: commonPath,
        oldFile: commonFile,
        newFile: editedCommonFile,
      );

      await renamingService.renameIOS(
        executablePath: testExePath,
        projectName: projectName,
        appLabel: appLabel,
        bundleId: bundleId,
      );

      verifyRenaming(path: plistPath, result: editedPlist);
      verifyRenaming(path: commonPath, result: editedCommonFile);
    });
  });
}
