# Build stage - install dependencies and build the application
FROM node:25-alpine AS builder

WORKDIR /app

# Copy dependency manifests first for better layer caching
COPY package.json yarn.lock* ./

# Install all dependencies (including devDependencies for build)
RUN yarn install --frozen-lockfile

# Copy source code and configuration files needed for build
COPY next.config.js ./
COPY tsconfig.json ./
COPY postcss.config.js ./
COPY tailwind.config.js ./
COPY public ./public
COPY src ./src
COPY tailwindPlugins ./tailwindPlugins

# Build argument for Sentry source map uploads
ARG SENTRY_AUTH_TOKEN
ENV SENTRY_AUTH_TOKEN=${SENTRY_AUTH_TOKEN}

# Build the Next.js application
# Sentry will automatically upload source maps during build if SENTRY_AUTH_TOKEN is set
RUN yarn next build

# Runtime stage - minimal image with only production dependencies
FROM node:25-alpine AS runtime

WORKDIR /app

# Create non-root user (UID 10001 as per best practices)
RUN addgroup -g 10001 -S nodejs && \
    adduser -S nextjs -u 10001

# Copy package files for production dependency installation
COPY package.json yarn.lock* ./

# Install only production dependencies
RUN yarn install --frozen-lockfile --production && \
    yarn cache clean

# Copy built application from builder stage
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/next.config.js ./
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./

# Set ownership of entire app directory
RUN chown -R nextjs:nodejs /app

# Switch to non-root user
USER nextjs

# Port is configurable via UI_SERVICE_PORT or PORT environment variable at runtime
# Next.js reads PORT env var automatically (defaults to 3000 if not set)
ENV PORT=3000
EXPOSE 3000

# Use exec form for proper signal handling
# Next.js automatically uses the PORT environment variable
CMD ["node_modules/.bin/next", "start"]
