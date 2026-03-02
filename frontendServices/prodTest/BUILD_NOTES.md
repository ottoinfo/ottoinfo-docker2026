# Production Dockerfile - Build Notes

## Overview

This production-ready Dockerfile generates a secure, optimized multi-stage Docker image for the Next.js application. The Dockerfile follows security best practices and is designed for production deployment.

## Project Analysis

### Technology Stack
- **Framework**: Next.js 16.1.1
- **Runtime**: Node.js 25 (Alpine Linux)
- **Package Manager**: Yarn
- **Language**: TypeScript
- **Styling**: Tailwind CSS 4.1.18
- **UI Library**: Material-UI (MUI) v6
- **Error Tracking**: Sentry (@sentry/nextjs)

### Key Dependencies
- React 19.2.3
- Next.js 16.1.1
- TypeScript 5.5.3
- Sentry for error tracking and source map uploads

## Dockerfile Structure

### Stage 1: Builder
- **Base Image**: `node:25-alpine`
- **Purpose**: Install dependencies and build the application
- **Actions**:
  1. Copy dependency manifests (`package.json`, `yarn.lock`) for layer caching
  2. Install all dependencies (including devDependencies needed for build
  3. Copy source code and configuration files
  4. Build the Next.js application with Sentry source map uploads

### Stage 2: Runtime
- **Base Image**: `node:25-alpine` (minimal runtime)
- **Purpose**: Production runtime with minimal dependencies
- **Security Features**:
  - Non-root user (`nextjs` with UID 10001)
  - Only production dependencies installed
  - Minimal base image (Alpine Linux)
- **Actions**:
  1. Create non-root user
  2. Install only production dependencies
  3. Copy built artifacts from builder stage
  4. Set proper ownership
  5. Switch to non-root user before exposing ports

## Build Arguments

### SENTRY_AUTH_TOKEN
- **Type**: Build argument
- **Purpose**: Authenticate Sentry source map uploads during build
- **Usage**: `--build-arg SENTRY_AUTH_TOKEN=your_token_here`
- **Note**: Only needed if you want source maps uploaded to Sentry during build

## Environment Variables

### PORT (Runtime) - Primary
- **Purpose**: Configure the port the application listens on (Next.js reads this automatically)
- **Default**: 3000
- **Usage**: `-e PORT=4000`
- **Note**: This is the standard Next.js environment variable

### UI_SERVICE_PORT (Runtime) - Alternative
- **Purpose**: Alternative port configuration variable (for consistency with your docker-compose setup)
- **Usage**: Set both `PORT` and `UI_SERVICE_PORT` to the same value: `-e PORT=4000 -e UI_SERVICE_PORT=4000`
- **Note**: Next.js reads `PORT`, so if you only set `UI_SERVICE_PORT`, you must also set `PORT` to the same value

### NODE_ENV (Optional)
- **Purpose**: Set Node.js environment
- **Recommended**: `production` for production deployments
- **Usage**: `-e NODE_ENV=production`

## Build Commands

**Important**: The build context must be the portfolio directory (where the source code lives), not the prodTest directory. The Dockerfile is located in prodTest but expects to copy files from the portfolio directory.

### Using the Build Script (Recommended)
```bash
cd /Users/mattotto/Sites/do2026/docker/frontendServices/prodTest
./build.sh otto-info-prod
```

With Sentry token:
```bash
SENTRY_AUTH_TOKEN=your_token ./build.sh otto-info-prod
```

### Manual Build
```bash
cd /Users/mattotto/Sites/do2026/portfolio
docker build \
  -f /Users/mattotto/Sites/do2026/docker/frontendServices/prodTest/Dockerfile \
  -t otto-info-prod \
  .
```

### Build with Sentry Source Maps
```bash
cd /Users/mattotto/Sites/do2026/portfolio
docker build \
  --build-arg SENTRY_AUTH_TOKEN=your_sentry_token \
  -f /Users/mattotto/Sites/do2026/docker/frontendServices/prodTest/Dockerfile \
  -t otto-info-prod \
  .
```

## Run Commands

### Basic Run
```bash
docker run -d \
  --name otto-info-prod \
  -p 3000:3000 \
  -e UI_SERVICE_PORT=3000 \
  otto-info-prod
```

### Run with Custom Port
```bash
docker run -d \
  --name otto-info-prod \
  -p 4000:4000 \
  -e PORT=4000 \
  -e UI_SERVICE_PORT=4000 \
  -e NODE_ENV=production \
  otto-info-prod
```

**Note**: Set both `PORT` (which Next.js reads) and `UI_SERVICE_PORT` (for consistency) to the same value.

### Run with Environment File
```bash
docker run -d \
  --name otto-info-prod \
  -p 3000:3000 \
  --env-file .env \
  otto-info-prod
```

## Security Features

1. **Non-root User**: Application runs as `nextjs` user (UID 10001) instead of root
2. **Minimal Base Image**: Alpine Linux reduces attack surface
3. **Production Dependencies Only**: Dev dependencies excluded from final image
4. **No Secrets in Image**: Environment variables and secrets passed at runtime
5. **Multi-stage Build**: Build tools excluded from final image
6. **Layer Caching**: Dependency manifests copied first for optimal caching

## Image Optimization

- **Multi-stage Build**: Separates build dependencies from runtime
- **Layer Caching**: Dependency files copied before source code
- **Alpine Base**: Smaller image size (~50-100MB vs 300-500MB for full Node image)
- **Production Dependencies Only**: Reduces final image size
- **Explicit COPY**: Only necessary files copied (no `COPY . .`)

## Validation Checklist

Before deploying to production, verify:

- [ ] Image builds successfully without errors
- [ ] Container starts and application is accessible
- [ ] Application responds on the configured port
- [ ] No errors in container logs
- [ ] Non-root user is being used (`docker exec container id`)
- [ ] Environment variables are properly set
- [ ] Sentry source maps uploaded (if SENTRY_AUTH_TOKEN provided)

## Troubleshooting

### Build Fails
- **Issue**: Missing files
  - **Solution**: Ensure you're building from the portfolio directory or adjust COPY paths
- **Issue**: Yarn lock file issues
  - **Solution**: Ensure `yarn.lock` exists and is up to date

### Container Won't Start
- **Issue**: Port already in use
  - **Solution**: Change the port mapping: `-p 4000:3000`
- **Issue**: Permission errors
  - **Solution**: Verify non-root user has proper ownership (should be automatic)

### Application Errors
- **Issue**: Missing environment variables
  - **Solution**: Ensure all required env vars are set (check `next.config.js` and application code)
- **Issue**: Sentry errors
  - **Solution**: Verify `SENTRY_AUTH_TOKEN` is set if using Sentry features

## Differences from Development Dockerfile

1. **Standalone Image**: Source code copied into image (no volume mounts)
2. **Production Dependencies**: Only production deps in final image
3. **Non-root User**: Security best practice
4. **Optimized Layers**: Better caching and smaller image size
5. **No Development Tools**: No dev dependencies or tools in final image

## Next Steps

1. **Test the Build**: Build and run the image locally
2. **Configure CI/CD**: Integrate into your deployment pipeline
3. **Set Environment Variables**: Configure all required runtime variables
4. **Monitor**: Set up logging and monitoring for production
5. **Security Scan**: Run `trivy` or similar tools to scan for vulnerabilities

## Notes

- The Dockerfile assumes the build context is the portfolio directory (where `package.json` and source code live)
- Port configuration is flexible - use `UI_SERVICE_PORT` or `PORT` environment variable
- Sentry source map uploads happen automatically during build if `SENTRY_AUTH_TOKEN` is provided
- The image is multi-architecture compatible (works on both amd64 and arm64)
