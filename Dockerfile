# 1. Define the base environment with Bun installed
FROM oven/bun:1.1-alpine AS base
WORKDIR /app

# 2. Copy lockfiles and install dependencies
COPY package.json bun.lockb* ./
RUN bun install

# 3. Copy the rest of your Astro source code
COPY . .

# 4. Run the build command directly on the base image
RUN bun run build

# 5. Keeps the container alive just long enough to copy files to your volume
CMD ["echo", "Build completed successfully!"]
