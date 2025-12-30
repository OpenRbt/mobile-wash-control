FROM dart:3.8.3-sdk AS build

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN apt-get update && apt-get install -y \
  curl unzip xz-utils zip git && \
  rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter && \
  flutter config --enable-web

#RUN useradd -m flutter && echo "flutter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
#USER flutter
#WORKDIR /home/flutter


WORKDIR /app
COPY pubspec.* ./

RUN flutter pub cache repair

COPY . .

RUN flutter pub run easy_localization:generate -S assets/translations/
RUN flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations/

RUN flutter build web --release

FROM nginx:1.27.5-alpine-slim

COPY --from=build /app/build/web /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
