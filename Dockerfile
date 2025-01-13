# Stage 1: Build the application
FROM golang:alpine AS builder

WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o my-go-app

# Stage 2: Create a minimal runtime image
FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/my-go-app .

# Expose the port
EXPOSE 9090

# Run the application
CMD ["./my-go-app"]
