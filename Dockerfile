FROM node:current-slim

RUN npm install -g @anthropic-ai/claude-code

CMD ["claude"]