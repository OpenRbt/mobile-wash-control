FROM ubuntu:18.04 as builder

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libwebkit2gtk-4.0-dev


WORKDIR /devtools

RUN git clone https://github.com/flutter/flutter.git

WORKDIR /devtools/flutter
RUN git checkout 3.7.12

ENV PATH "$PATH:/devtools/flutter/bin"

RUN flutter precache

COPY exec.sh /exec.sh
RUN chmod a+x /exec.sh

ENTRYPOINT [ "/exec.sh" ]