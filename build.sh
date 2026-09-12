#!/bin/bash
set -e

rm -rf app settings.gradle build.gradle gradle* gradlew*

mkdir -p app/src/main/java/com/hanuman/matka
mkdir -p app/src/main/res/values

cat << 'EOF' > app/src/main/java/com/hanuman/matka/MainActivity.java
package com.hanuman.matka;

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
    package="com.hanuman.matka">
    <application
        android:allowBackup="true"
        android:label="Hanuman Matka">
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
    namespace 'com.hanuman.matka'
    compileSdk 34
    defaultConfig {
        applicationId "com.hanuman.matka"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }
}
EOF

gradle wrapper --gradle-version 8.1.1 --distribution-type bin
./gradlew clean assembleDebug --stacktrace

