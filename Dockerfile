FROM debian:stable

ENV HOME /root
ENV PATH $PATH:$HOME/.local/bin
ENV PATH $PATH:$HOME/.ghcup/bin
ENV PATH $PATH:$HOME/.ghcup/env

WORKDIR $HOME
RUN apt-get -y update
RUN apt-get -y install libicu-dev libncurses-dev \
                zlib1g-dev build-essential curl \
                libffi-dev libffi6 libgmp-dev \
                libgmp10 libncurses-dev libncurses5 \
                libtinfo5 gcc
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

RUN ghcup install ghc 9.0.1
RUN cabal install phoityne-vscode haskell-dap hlint stylish-haskell hoogle ormolu

RUN ghcup install stack
RUN stack config --system-ghc set system-ghc --global true

RUN ghcup install hls

ENTRYPOINT ["/bin/bash"]