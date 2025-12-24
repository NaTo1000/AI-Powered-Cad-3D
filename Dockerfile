# Docker configuration for Business Central development environment
# This Dockerfile creates a containerized BC environment for development

FROM mcr.microsoft.com/businesscentral/onprem:latest

# Set environment variables
ENV accept_eula=Y \
    accept_outdated=Y \
    username=admin \
    password=P@ssw0rd123! \
    usessl=N \
    updatehosts=N

# Copy AL application files
COPY app.json /app/
COPY src/ /app/src/

# Expose Business Central ports
EXPOSE 80 443 7045-7049 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 \
  CMD powershell -Command "try { Invoke-WebRequest -Uri 'http://localhost/BC/HealthCheck' -UseBasicParsing -TimeoutSec 10 | Out-Null; exit 0 } catch { exit 1 }"

# Set working directory
WORKDIR /app

# Default command
CMD ["powershell", "-Command", "Start-Sleep -Seconds 3600"]
