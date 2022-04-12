import 'package:surf_flutter_starter/src/config/config.dart';

/// Single user-specified [ConfigParameter] for [Config].
abstract class ConfigParameter<T extends Object?> {
  /// Value of [ConfigParameter].
  T get value;

  /// Validates value.
  bool get isValid;

  /// Empty constructor.
  const ConfigParameter();

  @override
  String toString() {
    return '|${runtimeType}: $value. Valid:$isValid|';
  }
}

/// Directory path, in which project is going to be created.
class ProjectPath extends ConfigParameter<String?> {
  final String? value;

  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which Path [value] is passed.
  const ProjectPath(this.value);
}

/// Name of project, that is going to be created.
class ProjectName extends ConfigParameter<String?> {
  final String? value;

  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which project name [value] is passed.
  const ProjectName(this.value);
}

/// Application ID of project, that is going to be created.
class AppID extends ConfigParameter<String?> {
  final String? value;

  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which appID [value] is passed.
  const AppID(this.value);
}
