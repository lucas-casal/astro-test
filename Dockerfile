# syntax=docker/dockerfile:1
FROM oven/bun:1.1-alpine AS base
WORKDIR /src
COPY package.json bun.lockb* ./
RUN bun add
COPY . .

RUN pip install -r requirements.txt  # Installs the Python dependencies
COPY . .  # Copies the current directory `.` in the project to the workdir `.` in the image
FROM base AS development
EXPOSE 4321
CMD ["bun", "run", "dev", "--host", "0.0.0.0"]

FROM base AS build
RUN bun run build

FROM httpd:2.4-alpine AS production
EXPOSE 80
CMD ["httpd-foreground"]