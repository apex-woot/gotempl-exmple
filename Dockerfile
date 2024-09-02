# Stage 1: Generate files using templ
FROM ghcr.io/a-h/templ:latest AS generate-stage

WORKDIR /app

# Copy the source code into the container
COPY --chown=65532:65532 . .

# Generate files using templ
RUN ["templ", "generate"]

# Stage 2: Build the Go binary
FROM golang:1.22 AS builder

WORKDIR /app

# Copy the Go Modules manifests and install dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code and generated files from the previous stage
COPY --from=generate-stage /app .

# Build the binary
RUN mkdir -p ./out && GOARCH=amd64 GOOS=linux go build -o ./out/dist ./cmd/main.go

# Stage 3: Create a minimal image with the built binary
FROM scratch

# Set the working directory
WORKDIR /root

# Copy the binary from the builder stage
COPY --from=builder ./app/out/dist ./dist

# Set the binary as the entry point
ENTRYPOINT ["./dist"]
