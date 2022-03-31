import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/services/dialog_service.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

class ConfigRepository {
  final DialogService _dialogService;

  ConfigRepository(this._dialogService);

  String getProjectNameInput() {
    try {
      final projectName = _dialogService.getUserInput(userPrompt: 'userPrompt');
      return projectName;
    } on InputException catch (e) {
      Logger.error(e.message);
      throw RepositoryException(e.message);
    }
  }
}
