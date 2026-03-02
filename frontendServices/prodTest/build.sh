#!/bin/bash
# Build script for production Docker image
# This script builds the Docker image from the portfolio directory

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PORTFOLIO_DIR="/Users/mattotto/Sites/do2026/portfolio"
DOCKERFILE_PATH="${SCRIPT_DIR}/Dockerfile"
IMAGE_NAME="${1:-otto-info-prod}"
SENTRY_TOKEN="${SENTRY_AUTH_TOKEN:-}"

echo -e "${BLUE}Building production Docker image...${NC}"
echo -e "${YELLOW}Image name: ${IMAGE_NAME}${NC}"
echo -e "${YELLOW}Build context: ${PORTFOLIO_DIR}${NC}"
echo -e "${YELLOW}Dockerfile: ${DOCKERFILE_PATH}${NC}"

if [ ! -d "$PORTFOLIO_DIR" ]; then
    echo -e "${YELLOW}Error: Portfolio directory not found at ${PORTFOLIO_DIR}${NC}"
    exit 1
fi

if [ ! -f "$DOCKERFILE_PATH" ]; then
    echo -e "${YELLOW}Error: Dockerfile not found at ${DOCKERFILE_PATH}${NC}"
    exit 1
fi

# Build command
BUILD_CMD="docker build -f ${DOCKERFILE_PATH} -t ${IMAGE_NAME}"

# Add Sentry token if provided
if [ -n "$SENTRY_TOKEN" ]; then
    echo -e "${BLUE}Including Sentry auth token for source map uploads${NC}"
    BUILD_CMD="${BUILD_CMD} --build-arg SENTRY_AUTH_TOKEN=${SENTRY_TOKEN}"
else
    echo -e "${YELLOW}Warning: SENTRY_AUTH_TOKEN not set. Source maps will not be uploaded to Sentry.${NC}"
fi

BUILD_CMD="${BUILD_CMD} ${PORTFOLIO_DIR}"

echo -e "${BLUE}Running: ${BUILD_CMD}${NC}"
echo ""

# Execute build
eval $BUILD_CMD

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ Build successful!${NC}"
    echo -e "${BLUE}To run the container:${NC}"
    echo -e "  docker run -d --name ${IMAGE_NAME} -p 3000:3000 -e UI_SERVICE_PORT=3000 ${IMAGE_NAME}"
else
    echo ""
    echo -e "${YELLOW}✗ Build failed${NC}"
    exit 1
fi
