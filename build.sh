#!/bin/bash
set -e

rm -rf app settings.gradle build.gradle gradle* gradlew* .gradle

mkdir -p app/src/main/java/com/rudra/virtualgame
mkdir -p app/src/main/res/values

cat << 'EOF' > app/src/main/java/com/rudra/virtualgame/MainActivity.java
package com.rudra.virtualgame;

import android.app.Activity;
import android.os.Bundle;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }
}
EOF

cat << 'EOF' > app/src/main/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.rudra.virtualgame">
    <application
        android:allowBackup="true"
        android:label="Virtual Game">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

cat << 'EOF' > settings.gradle
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "RudraVirtualGame"
include ':app'
EOF

cat << 'EOF' > build.gradle
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.0'
    }
}
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

cat << 'EOF' > app/build.gradle
apply plugin: 'com.android.application'

android {
    namespace 'com.rudra.virtualgame'
    compileSdk 34

    defaultConfig {
        applicationId "com.rudra.virtualgame"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }
}
EOF

wget -q https://services.gradle.org/distributions/gradle-8.5-bin.zip
unzip -q gradle-8.5-bin.zip
export PATH="$PWD/gradle-8.5/bin:$PATH"

gradle wrapper --gradle-version 8.5 --distribution-type bin
./gradlew clean assembleDebug --stacktrace

