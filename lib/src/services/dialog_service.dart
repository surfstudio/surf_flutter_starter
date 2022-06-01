import 'package:surf_flutter_starter/src/utils/logger.dart';
import 'package:surf_flutter_starter/src/utils/terminal.dart';

/// Interacts with user to get information.
abstract class DialogService {
  /// Gets user's raw input.
  ///
  /// Firstly, prints [userPrompt], so that user can provide their input.
  /// Returns user's response as `String`.
  String getUserInput({required String userPrompt});

  /// Gets user's answer to (Y/N).
  ///
  /// Firstly, prints [userPrompt], so that user can provide their input.
  /// Returns user's response as `bool`.
  bool isYesInput({required String userPrompt});
}

/// Implementation of [DialogService], based on [Terminal]'s IO.
class TerminalDialogService implements DialogService {
  final Terminal _terminal;

  /// [TerminalDialogService]'s constructor, in which [Terminal] is passed.
  TerminalDialogService(this._terminal);

  @override
  String getUserInput({required String userPrompt}) {
    Logger.info(userPrompt);
    final input = _terminal.getUserInput()!;
    return input;
  }

  @override
  bool isYesInput({required String userPrompt}) {
    Logger.info(userPrompt);
    final input = _terminal.getUserInput()!;
    return input.toLowerCase().trim() == 'y';
  }
}
