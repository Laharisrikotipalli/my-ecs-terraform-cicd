#stage 1 build
FROM node:18-alpine AS builder

WORKDIR /app

COPY app/package*.json ./
RUN npm install --only=production

COPY app/ .

#stage 2 production
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app /app

ENV PORT=80

EXPOSE 80

CMD ["node", "index.js"]
