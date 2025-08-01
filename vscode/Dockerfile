ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.8.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

###############################################################################
# Build arguments                                                             #
# --------------------------------------------------------------------------- #
ARG BUILD_ARCH=amd64
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

###############################################################################
# App versions                                                                #
# --------------------------------------------------------------------------- #
# https://github.com/home-assistant/cli/releases
# renovate: datasource=github-releases depName=home-assistant/cli versioning=loose
ARG HA_CLI_VERSION="4.39.0"
# https://github.com/coder/code-server/releases
# renovate: datasource=github-releases depName=coder/code-server versioning=loose
ARG CODE_SERVER_VERSION="v4.102.3"
# https://github.com/python-poetry/poetry/releases
# renovate: datasource=github-releases depName=python-poetry/poetry versioning=loose
ARG POETRY_VERSION="1.8.5"
# renovate: datasource=python-version depName=python versioning=python
ARG PYTHON_VERSION="3.13.5"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV PYENV_ROOT="$HOME/.pyenv"
ENV PYENV_VERSION=$PYTHON_VERSION
ENV TERM="xterm-256color"

###############################################################################
# Install packages, ha, pyenv, etc                                            #
# --------------------------------------------------------------------------- #
RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    bat \
    build-essential \
    cargo \
    colordiff \
    curl \
    direnv \
    git \
    iputils-ping \
    less \
    libarchive-tools \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    locales \
    mariadb-client \
    mosquitto-clients \
    net-tools \
    nmap \
    openssh-client openssh-server \
    pwgen \
    pkg-config \
    sudo \
    tk-dev \
    unzip \
    uuid-runtime \
    wget \
    xz-utils \
    zip \
    zsh \
    zlib1g-dev; \
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen; \
  locale-gen; \
  rm -rf "${HOME}/.config/pip"; \
  curl -L -s -o /usr/bin/ha "https://github.com/home-assistant/cli/releases/download/${HA_CLI_VERSION}/ha_${BUILD_ARCH}"; \
  chmod a+x /usr/bin/ha; \
  ha completion bash > /usr/share/bash-completion/completions/ha; \
  git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh; \
  git clone --single-branch --depth 1 \
    "https://github.com/zsh-users/zsh-autosuggestions" ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
  git clone --single-branch --depth 1 \
      "https://github.com/zsh-users/zsh-syntax-highlighting.git" ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting;\
  git clone --single-branch --depth 1 \
    "https://github.com/mattmc3/zshrc.d" ~/.oh-my-zsh/custom/plugins/zshrc.d; \
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash; \
  sed -i -e "s#bin/bash#bin/zsh#" /etc/passwd; \
  mkdir -p ~/.local/bin; \
  ln -s /usr/bin/batcat ~/.local/bin/bat; \
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

COPY rootfs /

###############################################################################
# Install nvm                                                                 #
# --------------------------------------------------------------------------- #
RUN set -ex; \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash; \
  source ~/.nvm/nvm.sh; \
  nvm install "lts/iron" --latest-npm; \
  nvm alias default "lts/iron"; \
  nvm cache clear;

###############################################################################
# Install Python & dependencies                                               #
# --------------------------------------------------------------------------- #
RUN set -ex; \
  source ~/.bash_profile; \
  PYTHON_CONFIGURE_OPTS="--enable-shared" \
  PROFILE_TASK='-m test.regrtest --pgo -j0' pyenv install "${PYENV_VERSION}"; \
  pyenv global "${PYENV_VERSION}"; \
  pip install setuptools wheel \
    --disable-pip-version-check --no-cache-dir --no-warn-script-location; \
  pip install --requirement /tmp/requirements.txt \
    --disable-pip-version-check \
    --no-cache-dir \
    --no-warn-script-location; \
  pipx install "poetry==${POETRY_VERSION}" --pip-args='--no-cache-dir'; \
  pipx inject poetry poetry-dynamic-versioning poetry-plugin-export --pip-args='--no-cache-dir'; \
  poetry config virtualenvs.create true; \
  poetry config virtualenvs.in-project true; \
  poetry config virtualenvs.prefer-active-python true; \
  poetry config warnings.export false;

###############################################################################
# Install code-server                                                         #
# --------------------------------------------------------------------------- #
RUN set -ex; \
  if [[ "${BUILD_ARCH}" = "aarch64" ]] || [[ "${BUILD_ARCH}" = "armhf" ]] || [[ "${BUILD_ARCH}" = "armv7" ]]; then \
    export ARCH="arm64"; \
  fi; \
  if [[ "${BUILD_ARCH}" = "amd64" ]]; then export ARCH="amd64"; fi; \
  curl -J -L -o /tmp/code.tar.gz \
    "https://github.com/coder/code-server/releases/download/${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION#v}-linux-${ARCH}.tar.gz"; \
  mkdir -p /usr/local/lib/code-server; \
  tar zxvf /tmp/code.tar.gz --strip 1 -C /usr/local/lib/code-server; \
  ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server; \
  install-code-extensions;

###############################################################################
# Health check                                                                #
# --------------------------------------------------------------------------- #
HEALTHCHECK \
  CMD curl --fail http://127.0.0.1:9080/healthz || exit 1

###############################################################################
# Labels                                                                      #
# --------------------------------------------------------------------------- #
LABEL \
  io.hass.name="${BUILD_NAME}" \
  io.hass.description="${BUILD_DESCRIPTION}" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  maintainer="Kyle Finley <kyle@finley.sh>" \
  org.opencontainers.image.title="${BUILD_NAME}" \
  org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
  org.opencontainers.image.vendor="Kyle Finley <kyle@finley.sh>"  \
  org.opencontainers.image.authors="Kyle Finley <kyle@finley.sh>"  \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.url="https://github.com/finleyfamily" \
  org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
  org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}

###############################################################################
# Cleanup                                                                     #
# --------------------------------------------------------------------------- #
RUN set -ex; \
  apt-get purge --auto-remove -y \
    libarchive-tools \
    uuid-runtime; \
  find /usr/local \
    \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
    -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
    -exec rm -rf '{}' +; \
  rm -fr \
    /root/.cache \
    /tmp/* \
    /var/{cache,log}/* \
    /var/lib/apt/lists/*;
