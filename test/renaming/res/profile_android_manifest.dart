import 'test_res.dart';

/// Profile manifest content from flutter_template
const profileManifestTest = '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="dev.surf.flutter_template">
    <uses-permission android:name="android.permission.INTERNET" />
</manifest>
''';

/// Profile manifest content after renaming
const renamedProfileManifestTest = '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$bundleId">
    <uses-permission android:name="android.permission.INTERNET" />
</manifest>
''';
