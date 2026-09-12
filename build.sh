#!/bin/bash
set -e

rm -rf settings.gradle build.gradle gradle* gradlew* .gradle

# settings.gradle me plugin management add karo taaki plugin mil sake
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

# Root build.gradle me Android Gradle Plugin version specify karo
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

# app/build.gradle ko classic apply plugin ke sath likho taaki version mismatch na ho
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

    buildTypes {
        release {
            minifyEnabled false
        }
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.core:core-ktx:1.12.0'
}
EOF

# Gradle wrapper download karke build karo
wget -q https://services.gradle.org/distributions/gradle-8.5-bin.zip
unzip -q gradle-8.5-bin.zip
export PATH="$PWD/gradle-8.5/bin:$PATH"

gradle wrapper --gradle-version 8.5 --distribution-type bin
./gradlew clean assembleDebug --stacktrace
