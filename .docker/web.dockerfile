FROM node:14-alpine AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY web/package*.json ./
RUN npm install

FROM node:14-alpine AS builder
WORKDIR /app
COPY web/ .
COPY --from=deps /app/node_modules ./node_modules
RUN npm run build

FROM node:14-alpine AS runner
WORKDIR /app
ENV NODE_ENV development
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
USER nextjs
EXPOSE 3000
ENV PORT 3000

CMD ["npm", "run", "start"]