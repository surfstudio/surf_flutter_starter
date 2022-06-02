surf_flutter_starter is a CLI tool for fast and easy creation of Flutter projects.

## Usage

To activate Flutter Starter, you have to add it to pub:
```sh
$ dart pub global activate surf_flutter_starter
```

and then run

```sh
$ dart pub global activate surf_flutter_starter
```

Dialog prompts will appear to follow project creation process.

## Features

Flutter project creation based on surf template(https://github.com/surfstudio/surf-flutter-app-template).
For the time being, it can change:
- Project name.
- App ID.
- App Label.

## Getting started

Help in general:
```sh
CLI-tool for creating new Flutter projects, based on surf-flutter-app-template

Usage: surf_flutter_starter <command> [arguments]

Global options:
-h, --help       Print this usage information.
-v, --verbose    Print verbose output

Available commands:
  create   Creates new Flutter project based on Surf project template

```

Create command:
```sh
Usage: surf_flutter_starter create
-h, --help           Print this usage information.
-c, --config-path    Specify where config.json file is located.
```

## CLI Architecture
![Project Diagram](images/CLI-Project-Generator Structure.png)

### Jobs
Regular Job:
```dart
/// Atomic task, which does something and returns `Object?` on completion.
///
/// [Job]'s are used for project generation process. They are top-level entities,
/// which define several technical steps of creating new project. [Job]'s are
/// expandable. Meaning, that series of more [Job]'s can create more complex
/// structure.
abstract class Job {
  /// Executes specific task for project template creation.
  ///
  /// Returns `Object?`
  Future<Object?> execute();
}
```

Configurable Job:
```dart
/// [Job] requires [Config], as project-describing entity.
abstract class ConfigurableJob extends Job {
  /// Instance of [Config].
  ///
  /// Holds [Job]-specific instance of [Config], required for
  /// [Job.execute] & project creation process.
  late final Config config;

  /// Sets up [Job] before its' [Job.execute].
  ///
  /// Requires [Config].
  void setupJob(Config config) {
    this.config = config;
  }
}
```

### Config
Config is a set of parameters, which specify project, that is being created.
```dart
/// Describes new project, that is being created.
///
/// Consists of values & parameters, that are being inserted
/// into new project when it's being created by user. User
/// defines those values & parameters as [ConfigParameter]s
/// whilst interacting with CLI.
class Config {
  /// ...
}
```

