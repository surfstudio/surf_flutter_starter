import 'dart:io';

import 'package:surf_flutter_starter/src/utils/logger.dart';
import 'package:surf_flutter_starter/src/utils/replace_path_separators_x.dart';

/// Interface for basic directories operations.
abstract class DirectoryService {
  /// Creates file to [filePath].
  Future<void> createFile({
    required String filePath,
    required String fileName,
    required bool isRecursive,
  });

  /// Reads file from [filePath].
  ///
  /// Returns its content as `String`.
  String readFileAsString({
    required String filePath,
  });

  /// Updates file [content] from [filePath].
  void updateFile({
    required String filePath,
    required String content,
  });

  /// Updates directory to [newName] from [directoryPath].
  void updateDirectory({
    required String directoryPath,
    required String newName,
  });

  /// Updates all files contents from [directoryPath]
  void updateAllFiles({
    required String directoryPath,
    required String oldValue,
    required String newValue,
  });

  /// Deletes file from [filePath].
  void deleteFile({
    required String filePath,
  });

  /// Deletes directory from [directoryPath].
  void deleteDirectory({
    required String directoryPath,
  });

  /// Returns 'true' if file exists in [directoryPath].
  bool doesFileExist({
    required String directoryPath,
  });
}

/// Implementation of [DirectoryService], using dart:io.
class IODirectoryService implements DirectoryService {
  @override
  Future<void> createFile({
    required String filePath,
    required String fileName,
    required bool isRecursive,
  }) async {
    Logger.info('Creating file to $filePath');
    await Directory(filePath).create(recursive: isRecursive);
    await File('$filePath\\$fileName'.replacePathSeparators()).create(recursive: isRecursive);
  }

  @override
  String readFileAsString({required String filePath}) {
    Logger.info('Reading file content from $filePath');
    final file = File(filePath);
    return file.readAsStringSync();
  }

  @override
  void updateFile({
    required String filePath,
    required String content,
  }) {
    Logger.info('Updating file content from $filePath');
    final file = File(filePath);
    return file.writeAsStringSync(content);
  }

  @override
  void updateDirectory({
    required String directoryPath,
    required String newName,
  }) {
    Logger.info('Updating directory content from $directoryPath to $newName');
    final directory = Directory(directoryPath);
    // Rename old directory to new one.
    final newPath = directoryPath.replaceRange(
      directoryPath.lastIndexOf('\\') + 1,
      directoryPath.length,
      newName,
    );
    directory.renameSync(newPath);
  }

  @override
  void updateAllFiles({
    required String directoryPath,
    required String oldValue,
    required String newValue,
  }) {
    Logger.info('Updating all files contents from $directoryPath value $oldValue to $newValue');
    final directory = Directory(directoryPath);

    for (final file in directory.listSync(recursive: true).whereType<File>()) {
      if (!file.path.contains('.png')) {
        final newFileContent = file.readAsStringSync().replaceAll(oldValue, newValue);
        file.writeAsStringSync(newFileContent);
      }
    }
  }

  @override
  void deleteFile({required String filePath}) {
    Logger.info('Deleting file from $filePath');
    final file = File(filePath);
    file.deleteSync();
  }

  @override
  void deleteDirectory({required String directoryPath}) {
    Logger.info('Deleting directory from $directoryPath');
    final directory = Directory(directoryPath);
    directory.deleteSync(recursive: true);
  }

  @override
  bool doesFileExist({required String directoryPath}) {
    Logger.info('Checking file in $directoryPath');
    final file = File(directoryPath);
    return file.existsSync();
  }
}
