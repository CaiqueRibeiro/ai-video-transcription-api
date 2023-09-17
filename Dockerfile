FROM node:18.16.0-slim AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM node:18.16.0-slim AS production
WORKDIR /app
RUN apt-get update -y && apt-get install -y openssl
COPY --from=builder --chown=node:node ["/app/dist", "/app/prisma", "/app/package.json", "./"]
RUN npm install --omit=dev
USER node
EXPOSE 3333
CMD ["node", "server.js"]
