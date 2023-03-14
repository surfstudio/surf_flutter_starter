import 'package:surf_flutter_starter/test/renaming/res/test_res.dart';

/// MainActivity.kt from flutter_template
const activity = ''' 
package dev.surf.flutter_template

import io.flutter.embedding.android.FlutterActivity;

class MainActivity : FlutterActivity() {
}
''';

/// MainActivity.kt after renaming
const editedActivity = ''' 
package $bundleId

import io.flutter.embedding.android.FlutterActivity;

class MainActivity : FlutterActivity() {
}
''';
