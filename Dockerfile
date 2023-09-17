FROM node:16.17.0-slim AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM node:16.17.0-slim AS production
WORKDIR /app
COPY --from=builder --chown=node:node ["/app/dist", "/app/prisma", "/app/package.json", "./"]
RUN npm install --only=production
USER node
EXPOSE 3333
CMD ["node", "server.js"]
