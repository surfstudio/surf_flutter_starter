/// Exception for internal tasks of project creation.
class JobException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// Constructor, which takes message and sets it empty otherwise.
  const JobException([this.message = '']);

  @override
  String toString() => 'Job Exception: $message';
}

/// Exception which is caused by git-specific and VCS operations.
class GitException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// Constructor, which takes message and sets it empty otherwise.
  const GitException([this.message = '']);

  @override
  String toString() => 'Git Exception: $message';
}

/// Exception which is caused by repository operations.
class RepositoryException implements Exception {
  /// Message, that describes [Exception].
  final String message;

  /// Constructor, which takes message and sets it empty otherwise.
  const RepositoryException([this.message = '']);

  @override
  String toString() => 'Repository Exception: $message';
}
