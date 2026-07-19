# syntax=docker/dockerfile:1
FROM oven/bun:1.1-alpine AS base
WORKDIR /src
COPY package.json bun.lockb* ./
RUN bun add
COPY . .

FROM base AS development
EXPOSE 4321
CMD ["bun", "run", "dev", "--host", "0.0.0.0"]

FROM base AS build
RUN bun run build

CMD ["echo", "Build completed successfully!"]