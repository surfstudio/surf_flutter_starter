import 'package:surf_flutter_starter/test/renaming/res/test_res.dart';

/// common.xcconfig content from flutter_template
const commonFile = '''
identifier=dev.surf.flutter_template
''';

/// common.xcconfig content after renaming
const editedCommonFile = ''' 
identifier=$bundleId
''';
