FROM node:current-slim

ENV WORKSPACE="/workspace"
ENV CLAUDE_CONFIG_DIR=$WORKSPACE/.claude-cfg
WORKDIR $WORKSPACE
RUN npm install -g @anthropic-ai/claude-code

CMD ["claude"]
