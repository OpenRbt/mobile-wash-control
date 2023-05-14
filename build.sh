flutter build apk --dart-define-from-file=build_config.json --release
flutter build linux --dart-define-from-file=build_config.json --release
cp build/app/outputs/flutter-apk/app-release.apk app_builds/android/app-release.apk
