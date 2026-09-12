#!/bin/bash
set -e

# 1. Sabhi purane aur faltu folders/files ko jad se saaf karo
rm -rf app settings.gradle build.gradle gradle* gradlew* .gradle

# 2. Bilkul naya clean Android folder structure banao
mkdir -p app/src/main/java/com/hanuman/matka
mkdir -p app/src/main/res/values

# 3. MainActivity.java banao
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

# 4. AndroidManifest.xml banao
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

# 5. settings.gradle banao
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
rootProject.name = "Hanuman-matka"
include ':app'
EOF

# 6. Root build.gradle banao
cat << 'EOF' > build.gradle
// Root build file
EOF

# 7. app/build.gradle banao (Modern plugins block ke sath)
cat << 'EOF' > app/build.gradle
plugins {
    id 'com.android.application'
}

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

    buildTypes {
        release {
            minifyEnabled false
        }
    }
}
EOF

# 8. Gradle wrapper download karke build karo
wget -q https://services.gradle.org/distributions/gradle-8.5-bin.zip
unzip -q gradle-8.5-bin.zip
export PATH="$PWD/gradle-8.5/bin:$PATH"

gradle wrapper --gradle-version 8.5 --distribution-type bin
./gradlew clean assembleDebug --stacktrace
