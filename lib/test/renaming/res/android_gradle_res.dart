import 'package:surf_flutter_starter/test/renaming/res/test_res.dart';

/// Gradle content from flutter_template
const gradleTest = '''
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new FileNotFoundException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "\$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
apply from: "../keystore/signingConfigs.gradle"

android {
    compileSdkVersion 32

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }


    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "dev.surf.flutter_template"
        minSdkVersion 21
        targetSdkVersion 32
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            // TODO: Add your own signing app_config.dart for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }

    flavorDimensions "release-type"

    productFlavors {
        dev {
            dimension "release-type"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }

        prod {
            dimension "release-type"
        }
    }
    lint {
        disable 'InvalidPackage'
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:\$kotlin_version"
    testImplementation 'junit:junit:4.13.1'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
}
''';

/// Gradle content after renaming
const editedGradleTest = '''
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new FileNotFoundException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "\$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
apply from: "../keystore/signingConfigs.gradle"

android {
    compileSdkVersion 32

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }


    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "$bundleId"
        minSdkVersion 21
        targetSdkVersion 32
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            // TODO: Add your own signing app_config.dart for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }

    flavorDimensions "release-type"

    productFlavors {
        dev {
            dimension "release-type"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }

        prod {
            dimension "release-type"
        }
    }
    lint {
        disable 'InvalidPackage'
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:\$kotlin_version"
    testImplementation 'junit:junit:4.13.1'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
}
''';
