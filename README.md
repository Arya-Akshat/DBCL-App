# 🚗 DBCL: Driver Behaviour & Credit Ledger

**DBCL** is a high-performance, real-time AI safety system migrated from native Kotlin to **Flutter**. It monitors driver attentiveness and calculates a "Credit Score" (DBCL) based on behavioral patterns, treating the driver as part of a closed-loop feedback system.

## 🌟 Key Features
- **Edge AI Monitoring**: Real-time drowsiness and distraction detection using **MediaPipe** and **TFLite** via a high-performance native Android bridge.
- **Dynamic Scoring**: Real-time credit deductions for safety violations (Fatigue, Drowsiness, Alcohol detection).
- **Clean Architecture**: Built using Domain-Driven Design (DDD) with Riverpod for state management and Drift for local persistence.
- **Background Service**: Reliable monitoring even when the app is backgrounded or navigating with Google Maps.
- **Floating Dashboard**: A persistent overlay dashboard to keep safety scores visible at all times.
- **Hardware Integration**: Built-in support for ESP32-based alcohol sensors via a local HTTP bridge on port 5001.

## 🛠️ Tech Stack
- **Framework**: Flutter (Dart)
- **Native Bridge**: Kotlin (Android MethodChannels)
- **Vision AI**: MediaPipe Face Landmarker, FaceNet (TFLite)
- **State Management**: Riverpod
- **Database**: Drift (SQLite)
- **Connectivity**: Shelf (Local HTTP Server)

## 🚀 Setup & Run
### Prerequisites
- Flutter SDK (>= 3.11.5)
- Android Studio / VS Code
- Pixel 6 Emulator (or physical device)

### Clone & Install
```bash
git clone https://github.com/Arya-Akshat/DBCL-App.git
cd flutter_driver_dbcl
flutter pub get
```

### Initialize Models
The AI models (`face_landmarker.task`, `facenet.tflite`) are embedded in the Android assets.

### Run
```bash
dart run build_runner build --delete-conflicting-outputs
flutter run
```
