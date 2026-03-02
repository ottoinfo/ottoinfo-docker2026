# Production Dockerfile

This directory contains a production-ready Dockerfile and supporting files for the Next.js application.

## Quick Start

### Build the Image
```bash
./build.sh otto-info-prod
```

### Run the Container
```bash
docker run -d \
  --name otto-info-prod \
  -p 3000:3000 \
  -e PORT=3000 \
  -e UI_SERVICE_PORT=3000 \
  -e NODE_ENV=production \
  otto-info-prod
```

## Files

- **Dockerfile** - Production-ready multi-stage Dockerfile
- **.dockerignore** - Optimized build context exclusions
- **build.sh** - Convenient build script
- **BUILD_NOTES.md** - Comprehensive documentation and build notes

## Documentation

See [BUILD_NOTES.md](./BUILD_NOTES.md) for:
- Detailed build instructions
- Environment variable configuration
- Security features
- Troubleshooting guide
- Best practices

## Key Features

✅ Multi-stage build for optimized image size
✅ Non-root user for security
✅ Production dependencies only
✅ Sentry source map upload support
✅ Configurable port via environment variables
✅ Alpine Linux base for minimal footprint
