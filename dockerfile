# Stage 1: Base image with whisper installed
# Build only this stage: docker build --target whisper-base -t whisper-base:latest .
FROM python:3.10-slim AS whisper-base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install ffmpeg (required for whisper) and git (required for pip install from git)
RUN apt-get update && \
    apt-get install -y ffmpeg git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install whisper (and torch, which is a dependency) - 13GB layer
# Pin to main branch for consistent caching
RUN pip install git+https://github.com/openai/whisper.git@main

# Clean any previous (possibly corrupted) model cache
RUN rm -rf /root/.cache/whisper

# ------------------------------------------------------------
# Stage 2: Application image - uses whisper-base as foundation
# Build only this stage: docker build --target whisper-api -t whisper-api:latest .
# Or build both: docker build -t whisper-api:latest .
# FROM whisper-base AS whisper-api
FROM whisper-base:latest AS whisper-api

WORKDIR /app

# Expose port for API server
EXPOSE 5001

# Copy your application files
# These changes won't invalidate the whisper-base cache
COPY your-audio-file.mp3 /app/your-audio-file.mp3
COPY api_server.py /app/api_server.py

ENTRYPOINT ["python", "-u", "api_server.py"]
