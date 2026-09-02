# mobile_wash_control

mobile-wash-control.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

In order to generate new added localization, run this commands:
1) flutter pub run easy_localization:generate -S assets/translations/
2) flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations/

## Android release build

    ./build_apk_in_docker.sh

builds the release APK inside the Flutter image and writes it to
`build/android/app-release.apk`.

The APK is signed with `android/key.properties` when that file exists and falls
back to the debug key otherwise. A debug key is generated per machine and per
Docker build, so an APK signed with one cannot be installed over an APK signed
with another - copy `android/key.properties.sample` and point `storeFile` at the
release keystore before publishing a build. Neither the properties file nor the
keystore is committed.
