FROM --platform=$BUILDPLATFORM instrumentisto/flutter:3.41.6-androidsdk36-r0 AS build

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get
COPY . .

ARG api_base_url=""

RUN flutter pub run easy_localization:generate -S assets/translations/
RUN flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations/

RUN flutter build web --release --no-tree-shake-icons --dart-define=api_base_url="$api_base_url"

# Cache-bust fonts: rename with version suffix so browsers re-fetch
RUN cd build/web/assets/fonts && \
    for f in *.otf *.ttf; do \
      [ -f "$f" ] || continue; \
      base="${f%.*}"; ext="${f##*.}"; \
      mv "$f" "${base}_v14.${ext}"; \
    done && \
    cd /app/build/web/assets && \
    sed -i 's|MaterialIcons-Regular.otf|MaterialIcons-Regular_v14.otf|g' FontManifest.json

FROM nginx:1.27.5-alpine-slim

COPY --from=build /app/build/web /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
