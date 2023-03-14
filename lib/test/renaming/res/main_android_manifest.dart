import 'package:surf_flutter_starter/test/renaming/res/test_res.dart';

/// Main manifest content from flutter_template
const mainManifestTest = '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="dev.surf.flutter_template">
<uses-permission android:name="android.permission.INTERNET" />
<application
android:icon="@mipmap/ic_launcher"
android:label="flutter_template">
<activity
android:name=".MainActivity"
android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
android:exported="true"
android:hardwareAccelerated="true"
android:launchMode="singleTop"
android:theme="@style/LaunchTheme"
android:windowSoftInputMode="adjustResize">
<!-- Theme to apply as soon as Flutter begins rendering frames -->
<meta-data
android:name="io.flutter.embedding.android.NormalTheme"
android:resource="@style/NormalTheme" />
<intent-filter>
<action android:name="android.intent.action.MAIN" />
<category android:name="android.intent.category.LAUNCHER" />
</intent-filter>
</activity>
<meta-data
android:name="flutterEmbedding"
android:value="2" />
</application>
</manifest>
''';

/// Main manifest content after renaming
const renamedMainManifest = '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="$bundleId">
<uses-permission android:name="android.permission.INTERNET" />
<application
android:icon="@mipmap/ic_launcher"
android:label="$appLabel">
<activity
android:name=".MainActivity"
android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
android:exported="true"
android:hardwareAccelerated="true"
android:launchMode="singleTop"
android:theme="@style/LaunchTheme"
android:windowSoftInputMode="adjustResize">
<!-- Theme to apply as soon as Flutter begins rendering frames -->
<meta-data
android:name="io.flutter.embedding.android.NormalTheme"
android:resource="@style/NormalTheme" />
<intent-filter>
<action android:name="android.intent.action.MAIN" />
<category android:name="android.intent.category.LAUNCHER" />
</intent-filter>
</activity>
<meta-data
android:name="flutterEmbedding"
android:value="2" />
</application>
</manifest>
''';
