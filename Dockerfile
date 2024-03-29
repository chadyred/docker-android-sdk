FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

ARG SDK_VERSION=34.0.0
ENV ANDROID_HOME      /opt/android-sdk-linux
ENV ANDROID_SDK_HOME  ${ANDROID_HOME}
ENV ANDROID_SDK_ROOT  ${ANDROID_HOME}
ENV ANDROID_SDK       ${ANDROID_HOME}

ENV PATH "${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
ENV PATH "${PATH}:${ANDROID_HOME}/build-tools/${SDK_VERSION}"
ENV PATH "${PATH}:${ANDROID_HOME}/platform-tools"
ENV PATH "${PATH}:${ANDROID_HOME}/emulator"
ENV PATH "${PATH}:${ANDROID_HOME}/bin"

RUN dpkg --add-architecture i386 && \
    apt-get update -yqq && \
    apt-get install -y curl expect git libc6:i386 libgcc1:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 openjdk-17-jdk wget unzip vim && \
    apt-get clean

RUN groupadd android && useradd -d /opt/android-sdk-linux -g android android

COPY tools /opt/tools
COPY licenses /opt/licenses

WORKDIR /opt/android-sdk-linux

RUN /opt/tools/entrypoint.sh built-in

RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "build-tools;${SDK_VERSION}"
RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "platform-tools"
RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "platforms;android-34"
RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "system-images;android-34;google_apis;x86_64"

CMD /opt/tools/entrypoint.sh built-in
