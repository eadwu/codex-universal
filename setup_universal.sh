#! /usr/bin/bash --login

# set -euo pipefail

CODEX_ENV_NODE_VERSION=${CODEX_ENV_NODE_VERSION:-}
CODEX_ENV_RUBY_VERSION=${CODEX_ENV_RUBY_VERSION:-}
CODEX_ENV_RUST_VERSION=${CODEX_ENV_RUST_VERSION:-}
CODEX_ENV_GO_VERSION=${CODEX_ENV_GO_VERSION:-}
CODEX_ENV_JAVA_VERSION=${CODEX_ENV_JAVA_VERSION:-}

echo "Configuring language runtimes..."

if [ -n "${CODEX_ENV_NODE_VERSION}" ]; then
    echo "# Node.js: v${CODEX_ENV_NODE_VERSION}"

    nvm install "${CODEX_ENV_NODE_VERSION}"
    nvm use "${CODEX_ENV_NODE_VERSION}"
    npm install -g npm pnpm
    corepack enable
    corepack install -g yarn
    # 
    nvm alias default "${CODEX_ENV_NODE_VERSION}"
    nvm use --save "${CODEX_ENV_NODE_VERSION}"
    corepack enable
fi

if [ -n "${CODEX_ENV_RUBY_VERSION}" ]; then
    echo "# Ruby: ${CODEX_ENV_RUBY_VERSION}"
  
    mise use --global "ruby@${CODEX_ENV_RUBY_VERSION}"
    # 
    mise use --global "ruby@${CODEX_ENV_RUBY_VERSION}"
    ruby --version
fi

if [ -n "${CODEX_ENV_RUST_VERSION}" ]; then
    echo "# Rust: ${CODEX_ENV_RUST_VERSION}"
    
    rustup toolchain install ${CODEX_ENV_RUST_VERSION} --profile minimal --component rustfmt --component clippy
    rustup default "${CODEX_ENV_RUST_VERSION}"
    rustc --version
fi

if [ -n "${CODEX_ENV_GO_VERSION}" ]; then
    echo "# Go: go${CODEX_ENV_GO_VERSION}"

    mise use --global "go@${CODEX_ENV_GO_VERSION}"
    mise use --global "golangci-lint@2.1.6"
    # 
    mise use --global "go@${CODEX_ENV_GO_VERSION}"
    go version
fi

if [ -n "${CODEX_ENV_JAVA_VERSION}" ]; then
    echo "# Java: ${CODEX_ENV_JAVA_VERSION}"

    mise use --global "java@${CODEX_ENV_JAVA_VERSION}"
    mise use --global "gradle@8.14"
    mise use --global "maven@3.9.10"
    # 
    mise use --global "java@${CODEX_ENV_JAVA_VERSION}"
    java -version
fi

mise cache clear || true