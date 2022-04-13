import 'package:surf_flutter_starter/src/config/config.dart';

/// Single user-specified [ConfigParameter] for [Config].
abstract class ConfigParameter<T extends Object?> {
  /// Value of [ConfigParameter].
  final T value;

  /// Validates value.
  bool get isValid;

  /// Constructor, in which [value] is passed.
  const ConfigParameter(this.value);

  @override
  String toString() {
    return '|${runtimeType}: $value. valid: $isValid|';
  }
}

/// Directory path, in which project is going to be created.
class ProjectPath extends ConfigParameter<String?> {
  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which project path [value] is passed.
  const ProjectPath(String? value) : super(value);
}

/// Name of project, that is going to be created.
class ProjectName extends ConfigParameter<String?> {
  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which project name [value] is passed.
  const ProjectName(String? value) : super(value);
}

/// Application ID of project, that is going to be created.
class AppID extends ConfigParameter<String?> {
  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which appID [value] is passed.
  const AppID(String? value) : super(value);
}
