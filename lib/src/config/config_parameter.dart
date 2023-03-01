import 'package:surf_flutter_starter/src/config/config.dart';
import 'package:surf_flutter_starter/src/utils/replace_path_separators_x.dart';

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
  //Default path to main manifest.
  static final androidMainManifestPath = 'android\\app\\src\\main\\AndroidManifest.xml'.replacePathSeparators();
  //Default path to debug manifest.
  static final androidDebugManifestPath = 'android\\app\\src\\debug\\AndroidManifest.xml'.replacePathSeparators();
  //Default path to profile manifest.
  static final androidProfileManifestPath = 'android\\app\\src\\debug\\AndroidManifest.xml'.replacePathSeparators();
  //Default path to graddle manifest.
  static const androidAppGradlePath = 'android\\app\\build.gradle';

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

/// Application Label (name) of project, that is going to be created.
class AppLabel extends ConfigParameter<String?> {
  /// Default value of [AppLabel].
  static const defaultAppLabel = 'flutter_template';
  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which appID [value] is passed.
  const AppLabel(String? value) : super(value);
}

/// Application ID of project, that is going to be created.
class AppID extends ConfigParameter<String?> {
  /// Default value of [AppID].
  static const defaultPackageID = 'dev.surf.flutter_template';

  /// Default value of [AppID] (variant).
  static const defaultAppID = 'dev.surf.flutter_template';
  @override
  bool get isValid => value != null && value!.isNotEmpty;

  /// Constructor, in which appID [value] is passed.
  const AppID(String? value) : super(value);
}
