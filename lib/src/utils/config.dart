/// Describes new project, that is being created.
///
/// Consists of values & parameters, that are being inserted
/// into new project when it's being created by user. User
/// defines those values & parameters whilst interacting with
/// CLI.
// TODO(taranov): Migrate this to another Config. (lib/src/config/config.dart).
class Config {
  ///
  final String projectName;

  ///
  final String? projectDescription;

  ///
  final String organisationName;

  ///
  final String projectPath;

  ///
  final String? appIconPath;

  ///
  final Iterable<String>? flavors;

  ///
  final bool isWebSupport;

  ///
  final bool isWindowsSupport;

  ///
  final bool isLinuxSupport;

  ///
  final bool isMacOSSupport;

  ///
  final bool isFirebaseEnabled;

  ///
  final String? googleServicesJsonPath;

  ///
  Config({
    required this.projectName,
    this.projectDescription,
    required this.organisationName,
    required this.projectPath,
    required this.appIconPath,
    required this.flavors,
    this.isWebSupport = false,
    this.isWindowsSupport = false,
    this.isLinuxSupport = false,
    this.isMacOSSupport = false,
    this.isFirebaseEnabled = false,
    this.googleServicesJsonPath,
  });
}
