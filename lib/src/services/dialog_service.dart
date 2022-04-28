import 'package:surf_flutter_starter/src/utils/logger.dart';
import 'package:surf_flutter_starter/src/utils/terminal.dart';

/// Interacts with user to get information.
abstract class DialogService {
  /// Gets user's raw input.
  ///
  /// Firstly, prints [userPrompt], so that user can provide their input.
  /// Returns user's response as 'String'.
  String getUserInput({required String userPrompt});
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
}
