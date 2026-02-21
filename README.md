# GameZone 🎮

A premium Flutter application tailored for gaming enthusiasts. Browse massive game directories, stream live updates, and experience cutting-edge design with dynamic micro-animations—all backed by GetX state management and secure Firebase authentication.

## 🌟 Features
- **OTP Phone Authentication**: Fast, secure mobile login powered by Firebase Authentication with automatic SMS retrieval.
- **Persistent State Management**: Smart session handling remembers logged-in users and skips onboarding for returning users leveraging `SharedPreferences`.
- **Game Library Dashboard**: Displays an endless feed of games dynamically fetched from the [FreeToGame API](https://www.freetogame.com/api-doc).
- **Intelligent Lazy Loading**: Client-side pagination and "Pull-to-Refresh" logic smoothly handles massive data loads (300+ items) by rendering in blocks of 20 without stuttering.
- **Premium UI / UX**: Employs deep-blue thematic gradients, glowing drop shadows, modern typography, and an intricate 4-stage sequential onboarding animation.

## 🛠️ Technology Stack
- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management & Routing**: [GetX (get: ^4.6.6)](https://pub.dev/packages/get)
- **Authentication**: [Firebase Auth](https://pub.dev/packages/firebase_auth) & Firestore (`users` collection)
- **Networking**: [Dio](https://pub.dev/packages/dio) for optimized HTTP requests
- **Local Storage**: [SharedPreferences](https://pub.dev/packages/shared_preferences)

## 🏗️ Project Architecture
The project follows a standard scalable GetX architecture, isolating views, controllers, models, and network services:
```
lib/
├── ui/
│   ├── home/           # Main Game Dashboard (Pagination, API rendering)
│   ├── login/          # Phone Entry Auth & OTP Verification (Firebase)
│   ├── splash/         # Animated Sequential Splash Screens
│   └── game/           # (Future Expansion) Detailed view for each game
├── utils/
│   ├── api_service.dart # Dio configuration and endpoints
│   └── app_pages.dart   # GetX structured routing
└── web_view/
```

## 🚀 Getting Started

### 1. Prerequisites
Ensure you have the following installed on your machine:
- Flutter SDK (latest stable version)
- Dart SDK
- Android SDK (for mobile emulation)

### 2. Firebase Configuration
This project relies on Firebase for Authentication and Firestore. To run it locally:
1. Create a project at [Firebase Console](https://console.firebase.google.com/).
2. Add an Android app with the package name `com.example.newproj`.
3. Enable **Phone Authentication** as a Sign-in method.
4. Add a Cloud Firestore Database with a `users` collection.
5. Download your `google-services.json` file and place it in the `android/app/` directory.

### 3. Installation
Clone the repository and install the dependencies:
```bash
flutter clean
flutter pub get
```

### 4. Running the App
Deploy the app onto an emulator or physical device:
```bash
flutter run
```

## 🔐 Authentication Flow
1. **App Launch**: `Splash4` attempts to ping `FirebaseAuth.instance.currentUser`.
2. **Instant Login**: If a user exists, they are routed instantly to `/home`.
3. **Onboarding**: If no user exists, `SharedPreferences` checks `hasSeenOnboarding`. If false, plays tutorial (`/splash2...`). If true, skips to `/register`.
4. **Validation**: The user enters their phone number and submits the SMS OTP.
5. **Data Storage**: A successful connection stores the user's phone number and the server's current timestamp to Cloud Firestore before loading the Dashboard.
