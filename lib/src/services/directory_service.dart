import 'dart:io';

import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Interface for basic directories operations.
abstract class DirectoryService {
  /// Deletes file from [filePath].
  void deleteFile({
    required String filePath,
  });
}

/// Implementation of [DirectoryService], using dart:io.
class IODirectoryService implements DirectoryService {
  @override
  void deleteFile({required String filePath}) {
    Logger.info('Deleting file from $filePath');
    final file = File(filePath);
    file.deleteSync();
  }
}
