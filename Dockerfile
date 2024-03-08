FROM ubuntu:24.04
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get autoremove -y \
 && apt-get autoclean -y \
 && apt-get install -y \
 sudo \
 nano \
 wget \
 curl \
 git 
RUN useradd -G sudo -m -d /home/Jonas -s /bin/bash -p "$(openssl passwd -1 123)" Jonas 
USER Jonas 
WORKDIR /home/Jonas
RUN mkdir hacking \
 && cd hacking \
 && curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
 && chmod 764 pawned.sh \
 && cd .. 
RUN git config --global user.email "jonas@jorgensen.as" \
 && git config --global user.name "JonasLovik" \
 && git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
 && mkdir -p github.com/JonasLovik/sem02v24
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-amd64.tar.gz \ | tar xvz -C /usr/local
USER Jonas
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/Jonas/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"