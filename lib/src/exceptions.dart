import 'package:surf_flutter_starter/src/executor.dart';
import 'package:surf_flutter_starter/src/jobs/job.dart';

/// Exception for internal tasks of project creation.
class JobException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// Constructor, which takes message & sets it empty otherwise.
  const JobException([this.message = '']);

  @override
  String toString() => 'Job Exception: $message';
}

/// Exception which is caused by repository operations.
class RepositoryException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// Constructor, which takes message & sets it empty otherwise.
  const RepositoryException([this.message = '']);

  @override
  String toString() => 'Repository Exception: $message';
}

/// Exception which is caused by network operations.
class NetworkException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// HTTP-code, that describes exception's reason.
  final int? statusCode;

  /// Constructor, which takes message & status code.
  const NetworkException([
    this.message = '',
    this.statusCode = 400,
  ]);

  @override
  String toString() => 'Network Exception: $message; Status Code - $statusCode';
}

/// Exception which is caused by [Executor] operations.
///
/// Occurs when at least one [Job] fails.
class ExecutorException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// Constructor, which takes message & sets it empty otherwise.
  const ExecutorException([this.message = '']);

  @override
  String toString() => 'Executor Exception: $message';
}

/// Exception which is caused by user input.
class InputException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// Constructor, which takes message & sets it empty otherwise.
  const InputException([this.message = '']);

  @override
  String toString() => 'Value Exception: $message';
}
