FROM node:12

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y \
        libwebkitgtk-1.0-0 \
        cpio \
        rpm2cpio \
        wget \
        pciutils \
        zip \
        gnome-keyring

RUN useradd -m -G sudo tizen && \
    passwd -d tizen
USER tizen
WORKDIR /home/tizen

ARG T_VERSION=4.1

ARG T_BINARY=web-cli_Tizen_Studio_${T_VERSION}_ubuntu-64.bin
RUN wget http://download.tizen.org/sdk/Installer/tizen-studio_${T_VERSION}/${T_BINARY} \
	-O ./${T_BINARY} && \
	chmod +x ./${T_BINARY}

RUN ./${T_BINARY} --accept-license ~/tizen-studio && \
    rm ./${T_BINARY}

ENV PATH="$PATH:/home/tizen/tizen-studio/tools"
ENV PATH="$PATH:/home/tizen/tizen-studio/tools/ide/bin"

RUN echo $PATH

ENTRYPOINT dbus-run-session -- bash -c "echo password | gnome-keyring-daemon --unlock && bash"
