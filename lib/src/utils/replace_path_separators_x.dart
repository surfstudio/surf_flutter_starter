import 'dart:io';

/// Extension on `String` to replace path separators.
extension replacePathSeparatorsX on String {
  /// Replaces path separators in path to current [Platform.pathSeparator].
  String replacePathSeparators() {
    return replaceAll('\\', Platform.pathSeparator);
  }
}
