import 'test_res.dart';

/// Debug manifest content from flutter_template
const debugManifestTest = '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="dev.surf.flutter_template">
    <uses-permission android:name="android.permission.INTERNET" />
</manifest>
''';

/// Debug manifest content after renaming
const renamedDebugManifestTest = '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$bundleId">
    <uses-permission android:name="android.permission.INTERNET" />
</manifest>
''';
