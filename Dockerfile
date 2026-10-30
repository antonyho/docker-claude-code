FROM node:current-slim

ARG CLAUDE_CODE_VERSION=latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git openssh-client curl wget \
        build-essential pkg-config \
        python3 python3-pip python3-venv \
        ripgrep fd-find jq tree less file \
        unzip zip xz-utils \
        procps iputils-ping dnsutils netcat-openbsd \
        vim nano \
    && rm -rf /var/lib/apt/lists/*

ENV WORKSPACE="/workspace"
ENV CLAUDE_CONFIG_DIR=$WORKSPACE/.claude-cfg
WORKDIR $WORKSPACE
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION#v}

CMD ["claude"]
