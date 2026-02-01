FROM node:22-bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install pnpm
RUN corepack enable && corepack prepare pnpm@10 --activate

WORKDIR /app

# 1. Manually clone the repo
RUN git clone https://github.com/openclaw/openclaw.git .

# 2. Install dependencies (ignoring system libvips for sharp)
ENV SHARP_IGNORE_GLOBAL_LIBVIPS=1
RUN pnpm install

# 3. Build the project
RUN pnpm build

# 4. Create a symlink so the 'openclaw' command works
RUN ln -s /app/dist/entry.js /usr/local/bin/openclaw && chmod +x /app/dist/entry.js

# Ensure the workspace directory exists inside the container
RUN mkdir -p /app/workspace

ENTRYPOINT ["node", "/app/dist/entry.js"]