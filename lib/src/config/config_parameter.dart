import 'package:surf_flutter_starter/src/config/config.dart';

/// Single user-specified Parameter for [Config].
abstract class ConfigParameter {
  /// Value of a given parameter.
  ///
  /// May be implemented as any type. Defaults to nullable [Object].
  final Object? _value;

  /// Value's Getter.
  ///
  /// Assert value validity before value returns from function.
  Object get value {
    assert(isValid);
    return _value!;
  }

  /// Validates value.
  ///
  /// By default returns 'true' if value is not null.
  /// May be overridden to indicate specific values.
  bool get isValid => _value != null;

  /// Constructor, in which value is given.
  const ConfigParameter(this._value);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}

/// Default 'Empty' parameter.
class EmptyParameter implements ConfigParameter {
  @override
  bool get isValid => false;

  @override
  Object get value => throw UnimplementedError();

  @override
  Object? get _value => null;

  @override
  String toString() {
    return 'Empty Parameter. Nothing here';
  }
}

/// Directory path, in which project is going to be created.
class ProjectPath implements EmptyParameter {
  final String? _value;

  @override
  bool get isValid => _value != null && _value!.isNotEmpty;

  @override
  String get value {
    assert(isValid);
    return _value!;
  }

  /// Constructor, in which Path is passed.
  const ProjectPath(this._value);

  /// Empty factory.
  factory ProjectPath.empty() => ProjectPath(null);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}

/// Name of project, that is going to be created.
class ProjectName implements EmptyParameter {
  final String? _value;

  @override
  bool get isValid => _value != null && _value!.isNotEmpty;

  @override
  String get value {
    assert(isValid);
    return _value!;
  }

  /// Constructor, in which project name is passed.
  const ProjectName(this._value);

  /// Empty factory.
  factory ProjectName.empty() => ProjectName(null);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}

/// Application ID of project, that is going to be created.
class AppID implements EmptyParameter {
  final String? _value;

  @override
  bool get isValid => _value != null && _value!.isNotEmpty;

  @override
  String get value {
    assert(isValid);
    return _value!;
  }

  /// Constructor, in which appID value is passed.
  const AppID(this._value);

  /// Empty factory.
  factory AppID.empty() => AppID(null);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}
