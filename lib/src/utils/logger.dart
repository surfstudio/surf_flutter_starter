import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:cli_util/cli_logging.dart' as log;
import 'package:io/ansi.dart';
// ignore_for_file: avoid_print

/// Set logger for standard mode.
log.Logger logger = log.Logger.standard();

/// Basic logger, that prints stuff in console.
class Logger {
  Logger._();

  /// Sets logger to verbose output.
  static void setVerbose() {
    logger = log.Logger.verbose();
  }

  /// Prints success message
  static void fine(String message) {
    print(cyan.wrap(message));
    consoleController.fine.add(utf8.encode(message));
  }

  /// Prints [message] with warning formatting
  static void warning(String message) {
    print(yellow.wrap(message));
    consoleController.warning.add(utf8.encode(message));
  }

  /// Prints [message] with info formatting
  static void info(String message) {
    print(message);
    consoleController.info.add(utf8.encode(message));
  }

  /// Prints [message] with error formatting
  static void error(String message) {
    print(red.wrap(message));
    consoleController.error.add(utf8.encode(message));
  }
}

/// Console controller instance
final consoleController = ConsoleController();

/// Controls & handles all terminal-based streams & outputs.
class ConsoleController {
  /// Is running on CLI
  static bool isCli = false;

  /// Stdout stream.
  final stdout = StreamController<List<int>>();

  /// Stderr stream.
  final stderr = StreamController<List<int>>();

  /// Warning stream.
  final warning = StreamController<List<int>>();

  /// Fine stream.
  final fine = StreamController<List<int>>();

  /// Info stream.
  final info = StreamController<List<int>>();

  /// Error stream.
  final error = StreamController<List<int>>();

  /// Stdout stream sink.
  StreamSink<List<int>> get stdoutSink {
    return isCli ? io.stdout : stdout.sink;
  }

  /// Stderr stream sink.
  StreamSink<List<int>> get stderrSink {
    return isCli ? io.stderr : stderr.sink;
  }

  /// Closes all streams.
  void closeAll() {
    stdout.close();
    stderr.close();
    warning.close();
    fine.close();
    info.close();
    error.close();
  }
}
