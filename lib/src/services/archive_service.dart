import 'package:archive/archive_io.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Interface for basic archive operations.
abstract class ArchiveService {
  /// Extracts archive from [inputPath] to [outputPath].
  ///
  /// Returns `Future<void>`.
  ///
  /// May throw [FileSystemException].
  Future<void> extractArchive({
    required String inputPath,
    required String outputPath,
  });
}

/// Implementation of [ArchiveService], using archive package.
class ZipArchiveService implements ArchiveService {
  @override
  Future<void> extractArchive({
    required String inputPath,
    required String outputPath,
  }) async {
    try {
      Logger.info('Extracting from $inputPath to $outputPath');
      return extractFileToDisk(inputPath, outputPath);
    } on Exception catch (e) {
      throw FileSystemException(e.toString());
    }
  }
}
