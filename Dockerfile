FROM ubuntu:22.04 AS build

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl unzip xz-utils zip git libglu1-mesa ca-certificates bash file sudo && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m flutter && echo "flutter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER flutter
WORKDIR /home/flutter

RUN git clone https://github.com/flutter/flutter.git -b stable /home/flutter/flutter
ENV PATH="/home/flutter/flutter/bin:/home/flutter/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter config --enable-web

WORKDIR /home/flutter/app
COPY --chown=flutter:flutter pubspec.* ./
RUN flutter pub get

COPY --chown=flutter:flutter . .

RUN flutter build web --release

FROM nginx:alpine
COPY --from=build /home/flutter/app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
