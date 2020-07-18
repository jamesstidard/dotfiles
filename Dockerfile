FROM ubuntu:20.04

ARG USER=docker
ARG UID=1000
ARG GID=1000
ARG PASS=docker

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PASS}" | chpasswd
RUN apt update && apt install -y sudo && adduser ${USER} sudo

# Set the locale
RUN apt update && apt install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

VOLUME [ "/dotfiles" ]

RUN apt update && apt install -y git python

USER ${UID}:${GID}

WORKDIR /dotfiles
COPY --chown=${USER} . .

# run inplace with self destructive build
# docker run -it -v "$PWD:/dotfiles" (docker build -q .)
