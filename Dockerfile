FROM node:current-slim

ARG CLAUDE_CODE_VERSION=latest

ENV WORKSPACE="/workspace"
ENV CLAUDE_CONFIG_DIR=$WORKSPACE/.claude-cfg
WORKDIR $WORKSPACE
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION#v}

CMD ["claude"]
