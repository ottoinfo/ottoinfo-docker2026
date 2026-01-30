# Using a Docker File to Expose Port and Create User
FROM python:3.13
# Create a non-root user for security purposes
# Note that poetry needs access to a home dir to create its default virtualenv cache
RUN useradd -r -m -d /home/appuser appuser
# Set working directory
WORKDIR /app
USER appuser

RUN pip install --no-cache-dir poetry==1.8.5

EXPOSE 8000
ENV PORT 8000

