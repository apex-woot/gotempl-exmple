FROM golang:1.22 AS builder

WORKDIR /app

# Copy the Go Modules manifests
COPY go.mod go.sum ./

# Install dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

FROM ghcr.io/a-h/templ:latest AS generate-stage
COPY --chown=65532:65532 . /app
WORKDIR /app
RUN ["templ", "generate"]

# Build the binary
RUN mkdir -p ./out && make build


# Stage 2: Create a minimal image with the built binary
FROM scratch

# Set the working directory
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=builder /app/out/dist .

# Expose port if your application requires one (optional)
# EXPOSE 8080

# Run the binary
CMD ["./dist"]
