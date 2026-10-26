# FROM astral/uv:python3.12-bookworm-slim
FROM python:3.12-slim

### annoying cert stuff ###
# used to inject custom CA certificates into the image at build
ARG EXTRA_CA_CERT
RUN touch .dummy_fallback
COPY ${EXTRA_CA_CERT:-./.dummy_fallback} /usr/local/share/ca-certificates/additional_ca.crt

# RUN apt clean
# RUN apt -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update

RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

### create non-root cursor-user + environment ###
RUN useradd -m -s /bin/bash cursor-user && \
    echo "cursor-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/cursor-user
WORKDIR /workspace

USER cursor-user

# install cursor agent
RUN curl https://cursor.com/install -fsS | bash

# annoying color-theme stuff because cursor defaults to dark-mode and my terminal is light mode
ARG COLOR_THEME="light"
ENV TERM_THEME=$COLOR_THEME
ENV TERM=xterm-256color
RUN echo export TERM_THEME=$COLOR_THEME\nexport TERM=xterm-256color >> /home/cursor-user/.bashrc

# spawn command
CMD ["/bin/bash", "/home/cursor-user/.local/bin/cursor-agent", "||", "/bin/bash"]
