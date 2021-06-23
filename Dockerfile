FROM debian:stable

# Set env vars
ENV HOME /root
ENV PATH $PATH:$HOME/.local/bin
ENV PATH $PATH:$HOME/.ghcup/bin
ENV PATH $PATH:$HOME/.ghcup/env

# Set working directory
WORKDIR $HOME

# Install prerequisites
RUN apt-get -y update
RUN apt-get -y install libicu-dev libncurses-dev \
                zlib1g-dev build-essential curl \
                libffi-dev libffi6 libgmp-dev \
                libgmp10 libncurses-dev libncurses5 \
                libtinfo5 gcc
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Update ghc
RUN ghcup install ghc 9.0.1

# Install VSCode utils
RUN cabal install phoityne-vscode haskell-dap hlint stylish-haskell hoogle ormolu

# Install stack
RUN ghcup install stack

# Configure stack to use locally installedd ghc
RUN stack config --system-ghc set system-ghc --global true
RUN stack config --system-ghc set install-ghc --global false

# Install haskell language server
RUN ghcup install hls

ENTRYPOINT ["/bin/bash"]