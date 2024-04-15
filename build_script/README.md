<!--Сборка-->
## Linux
1. Подготовка образа Docker
```docker build -t build_mobile_wash_control .```

2. Удалите файл "pubspec.yaml" и переименуйте "pubspec (for Linux build).yaml" в "pubspec.yaml"
3. Запустите "build_app_in_docker.sh" из директории "build_script" внутри проекта

## Android

1. Выполнить следующую команду с указаним нужных параметров, взятых из Google Firebase
``` flutter build apk --release --dart-define=android_api_key="" --dart-define=android_app_id="" --dart-define=messaging_sender_id="" --dart-define=project_id="" --dart-define=storage_bucket="" ```