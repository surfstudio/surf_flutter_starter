import 'dart:io';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Interface for basic directories operations.
abstract class DirectoryService {
  /// Deletes file from [filePath].
  ///
  /// May throw [FileSystemException].
  void deleteFile({
    required String filePath,
  });
}

/// Implementation of [DirectoryService], using dart:io.
class IODirectoryService implements DirectoryService {
  @override
  void deleteFile({required String filePath}) {
    try {
      Logger.info('Deleting file from $filePath');
      final file = File(filePath);
      file.deleteSync();
    } on Exception catch (e) {
      throw FileSystemException(e.toString());
    }
  }
}
