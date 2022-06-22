FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID


RUN apt-get update
RUN apt install --no-install-recommends -y software-properties-common sudo
RUN apt-add-repository ppa:cubic-wizard/release
RUN apt-add-repository universe
RUN apt install --no-install-recommends -y dirmngr
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B7579F80E494ED3406A59DF9081525E2B4F1283B
RUN apt install --no-install-recommends -y cubic 

# Create the user
RUN groupadd --gid $USER_GID $USERNAME
RUN useradd --uid $USER_UID --gid $USER_GID -d /home/$USERNAME -m -G sudo $USERNAME
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
WORKDIR /home/$USERNAME

ADD ./entrypoint.sh /
ENTRYPOINT /entrypoint.sh
