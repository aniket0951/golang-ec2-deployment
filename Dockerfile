# Use the official Golang image as a base
FROM golang:1.23.0

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files and download dependencies
COPY go.mod .
RUN go mod download

# Copy the rest of the application files
COPY . .

# Build the Go application
RUN go build -o my-go-app

# Expose the port the app runs on
EXPOSE 9090

# Run the application
CMD ["./my-go-app"]
