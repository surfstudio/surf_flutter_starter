import 'dart:convert';
import 'dart:io';

/// Implements basic IO operations.
class Terminal {
  /// Gets user input.
  ///
  /// Waits for user to type something in terminal. When they do it,
  /// returns the line (that can be empty) as 'String'.
  /// Defaults to [utf8] encoding.
  String? getUserInput() {
    final line = stdin.readLineSync(encoding: utf8);
    return line;
  }
}
