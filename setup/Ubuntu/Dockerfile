FROM ubuntu:latest
ENV HOME /root
ENV USER root

RUN apt-get update 
RUN apt-get install git sudo -y

WORKDIR $HOME
RUN git clone https://github.com/nordinvandijk/dotfiles.git
WORKDIR $HOME/dotfiles
ENTRYPOINT ["sh", "setup/Ubuntu/installer.sh"]
