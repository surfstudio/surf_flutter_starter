import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:cli_util/cli_logging.dart' as log;
import 'package:io/ansi.dart';
// ignore_for_file: avoid_print

/// Set logger for standard mode
log.Logger logger = log.Logger.standard();

class Logger {
  Logger._();

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

class ConsoleController {
  /// Is running on CLI
  static bool isCli = false;

  /// stdout stream
  final stdout = StreamController<List<int>>();

  /// sderr stream
  final stderr = StreamController<List<int>>();

  /// warning stream
  final warning = StreamController<List<int>>();

  /// fine stream
  final fine = StreamController<List<int>>();

  /// info stream
  final info = StreamController<List<int>>();

  /// error stream
  final error = StreamController<List<int>>();

  /// stdout stream sink
  StreamSink<List<int>> get stdoutSink {
    return isCli ? io.stdout : stdout.sink;
  }

  /// stderr stream sink
  StreamSink<List<int>> get stderrSink {
    return isCli ? io.stderr : stderr.sink;
  }

  void _closeStdout() {
    stdout.close();
  }

  void _closeStderr() {
    stderr.close();
  }

  void _closeWarning() {
    warning.close();
  }

  void _closeFine() {
    fine.close();
  }

  void _closeInfo() {
    info.close();
  }

  void _closeError() {
    error.close();
  }
}
