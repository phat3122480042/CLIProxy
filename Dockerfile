# Build stage
FROM alpine:latest as builder

WORKDIR /app

# Copy binary if pre-built
COPY cli-proxy-api .

# Runtime stage
FROM alpine:latest

WORKDIR /app

# Install ca-certificates for HTTPS
RUN apk --no-cache add ca-certificates

COPY --from=builder /app/cli-proxy-api .
COPY config.yaml .
COPY config.example.yaml .

# Create auth directory
RUN mkdir -p auth logs

ENV HOST=0.0.0.0
ENV PORT=8317

EXPOSE 8317

CMD ["./cli-proxy-api"]
