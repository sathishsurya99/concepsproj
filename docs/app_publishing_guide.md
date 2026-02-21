# App Publishing & Deployment Guide

This document outlines the deployment process for publishing a Flutter application to the **Google Play Console** and **App Store Connect**, ensuring the project meets production-ready standards.

## 1. Google Play Console (Android)

### Prerequisites & Build-Ready Configuration
To prepare the Android build for the Play Store, the following configurations must be made:

1. **Application ID & Versioning:**
   - Ensured `applicationId` in `android/app/build.gradle.kts` is unique (e.g., `com.company.appname`).
   - Versioning (`versionCode` and `versionName`) is managed automatically via `pubspec.yaml` (e.g., `version: 1.0.0+1`).

2. **App Icons:**
   - Generated using the `flutter_launcher_icons` package or placed manually into `android/app/src/main/res/mipmap-*` folders.

3. **Release Keystore & Signing:**
   - Create a keystore: `keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key`
   - Store credentials in `android/key.properties` (added to `.gitignore` for security):
     ```properties
     storePassword=<password>
     keyPassword=<password>
     keyAlias=key
     storeFile=key.jks
     ```
   - Configured `android/app/build.gradle.kts` to read `key.properties` dynamically for the `release` build type.

4. **Minification & Shrinking:**
   - Enable R8/Proguard rules in `build.gradle.kts` using `isMinifyEnabled = true` and `isShrinkResources = true` to reduce the app size.

### Deployment Process
1. Run `flutter build appbundle --release` to generate the `.aab` (Android App Bundle).
2. Create an App in the Google Play Console.
3. Fill out the Store Listing (Title, Description, Screenshots, Privacy Policy URL).
4. Complete the Content Rating questionnaire and Data Safety form.
5. Create a new release on the **Internal Testing**, **Closed Testing**, or **Production** track.
6. Upload the `.aab` file, add release notes, and send the app for review.

---

## 2. App Store Connect (iOS)

### Prerequisites & Build-Ready Configuration
To prepare the iOS build for the App Store, the following configurations must be set up in Xcode or `ios/Runner.xcworkspace`:

1. **Bundle Identifier & Versioning:**
   - The Bundle ID is set under the **Signing & Capabilities** tab in Xcode (e.g., `com.company.appname`).
   - Versioning is synchronized with `pubspec.yaml` (automatically maps to `CFBundleShortVersionString` and `CFBundleVersion` in `Info.plist`).

2. **App Icons:**
   - Icons must be added to `Assets.xcassets/AppIcon.appiconset` with no transparency or alpha channels.

3. **Capabilities & Permissions (`Info.plist`):**
   - Provide usage descriptions for any required permissions (e.g., `NSCameraUsageDescription`, `NSLocationWhenInUseUsageDescription`).
   - Strip out any debugging frameworks if applicable.

4. **Code Signing:**
   - Requires an Apple Developer Account.
   - Set up Provisioning Profiles and Distribution Certificates via Xcode directly or manually through the Apple Developer portal.

### Deployment Process
1. Run `flutter build ipa --release` (which generates an `xcarchive` and builds the `.ipa` file).
2. Alternatively, open `ios/Runner.xcworkspace` in Xcode.
3. Select **Product > Archive** (make sure target is Any iOS Device).
4. Once the archive completes, the Organizer window opens. Click **Distribute App**.
5. Upload the build directly to App Store Connect.
6. In App Store Connect:
   - Create a new App record.
   - Fill out metadata (Screenshots for various screen sizes, Promotional Text, Description, Privacy Policy).
   - Select the uploaded build from TestFlight (requires processing time).
   - Submit for Apple Review.

---

## Continuous Integration / Continuous Deployment (CI/CD)
For scalable and automated deployments, tools like **Fastlane**, **GitHub Actions**, or **Codemagic** are highly recommended. Fastlane allows automated keystore/certificate management (`match`), incrementing build numbers, taking screenshots, and uploading binary files directly to Google Play and TestFlight.
