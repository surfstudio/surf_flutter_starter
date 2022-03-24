// TODO(taranov): Documentation.
///
abstract class ConfigParameter {
  ///
  final Object? _value;

  ///
  Object get value {
    assert(isValid);
    return _value!;
  }

  ///
  bool get isValid => _value != null;

  ///
  const ConfigParameter(this._value);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}

///
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

///
class ProjectPath implements EmptyParameter {
  ///
  final String? _value;

  @override
  bool get isValid => _value != null && _value!.isNotEmpty;

  @override
  String get value {
    assert(isValid);
    return _value!;
  }

  ///
  const ProjectPath(this._value);

  ///
  factory ProjectPath.empty() => ProjectPath(null);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}

///
class ProjectName implements EmptyParameter {
  ///
  final String? _value;

  @override
  bool get isValid => _value != null && _value!.isNotEmpty;

  @override
  String get value {
    assert(isValid);
    return _value!;
  }

  ///
  const ProjectName(this._value);

  ///
  factory ProjectName.empty() => ProjectName(null);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}

///
class AppID implements EmptyParameter {
  ///
  final String? _value;

  @override
  bool get isValid => _value != null && _value!.isNotEmpty;

  @override
  String get value {
    assert(isValid);
    return _value!;
  }

  ///
  const AppID(this._value);

  ///
  factory AppID.empty() => AppID(null);

  @override
  String toString() {
    return '${runtimeType}: $value. Valid:$isValid';
  }
}
