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
  /// Default path to gradle manifest.
  static const androidAppGradlePath = 'android\\app\\build.gradle';

  /// Default path to main manifest.
  static const androidMainManifestPath = 'android\\app\\src\\main\\AndroidManifest.xml';

  /// Default path to debug manifest.
  static const androidDebugManifestPath = 'android\\app\\src\\debug\\AndroidManifest.xml';

  /// Default path to profile manifest.
  static const androidProfileManifestPath = 'android\\app\\src\\profile\\AndroidManifest.xml';

  /// Path to kotlin activity class.
  static const oldKotlinPath =
      'android\\app\\src\\main\\kotlin\\com\\example\\flutter_template\\MainActivity.kt';

  /// Path to package id.
  static const oldIDPath = 'android\\app\\src\\main\\kotlin\\com\\example';

  /// Path to Plist.
  static const iosInfoPlistPath = 'ios\\Runner\\Info.plist';

  /// Path to ios common.
  static const iosCommonPath = 'ios\\Flutter\\common.xcconfig';

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
