# Python base image
FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /app

# Requirements copy
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy full project
COPY . .

# Render automatically provides PORT env
EXPOSE 10000

# Start Flask app using gunicorn
CMD gunicorn app:app --bind 0.0.0.0:$PORT --workers 2 --threads 4
