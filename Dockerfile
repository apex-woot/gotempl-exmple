# Stage 1: Generate and Build the Go binary
FROM golang:1.22 AS builder

FROM ghcr.io/a-h/templ:latest AS generate-stage
COPY --chown=65532:65532 . /app


WORKDIR /app

# Copy the Go Modules manifests
COPY go.mod go.sum ./

# Install dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Generate files using templ
RUN ["templ", "generate"]

# Create the output directory and build the binary
RUN mkdir -p ./out && GOARCH=amd64 GOOS=linux go build -o ./out/dist ./cmd/main.go

# Stage 2: Create a minimal image with the built binary
FROM scratch

# Set the working directory
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=builder /app/out/dist /dist

# Set the binary as the entry point
ENTRYPOINT ["/dist"]
