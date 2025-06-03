# Build stage
FROM golang:1.24.3-alpine AS builder

WORKDIR /app

# Copy go.mod and go.sum first, then download dependencies
COPY app/go.mod ./
RUN go mod download

# Copy the rest of the source code
COPY app/. .

# Build the Go app (replace 'main.go' with your entrypoint if different)
RUN go build -o go-app

# Final stage
FROM alpine:3.19

WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/go-app .

# Expose the port your app listens on
EXPOSE 3333

# Run the binary
CMD ["./go-app"]
