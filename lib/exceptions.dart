/// Exception for internal tasks of project creation
class JobException implements Exception {
  final String message;

  const JobException([this.message = '']);

  @override
  String toString() => 'Job Exception: $message';
}

class GitException implements Exception {
  final String message;

  const GitException([this.message = '']);

  @override
  String toString() => 'Git Exception: $message';
}
