import 'dart:io';

import 'package:surf_flutter_starter/src/utils/logger.dart';

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

  /// Deletes file from [filePath].
  void deleteFile({
    required String filePath,
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
    await File('$filePath\\$fileName').create(recursive: isRecursive);
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
  void deleteFile({required String filePath}) {
    Logger.info('Deleting file from $filePath');
    final file = File(filePath);
    file.deleteSync();
  }
}
