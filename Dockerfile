FROM python:3-alpine
LABEL org.opencontainers.image.authors="kerta1n"

WORKDIR /app

# Clone the repository with minimal history
RUN apk add --no-cache git build-base && \
    git clone --depth 1 https://github.com/pipeboard-co/meta-ads-mcp.git /tmp/repo && \
    mv /tmp/repo/* . && \
    rm -rf /tmp/repo && \
    pip install --no-cache-dir -r requirements.txt

# Environment variable for the token (will be overridden by compose)
ENV META_ACCESS_TOKEN="token-not-initialized!!"
EXPOSE 8695

# Run the server with the token from environment variable
CMD ["set", "-e", "&&", "python", "-m", "meta_ads_mcp"]
