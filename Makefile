BINARY_NAME=dist

build:
	templ generate
	GOARCH=amd64 GOOS=linux go build -o ./out/${BINARY_NAME} ./cmd/main.go

run: build
	./out/${BINARY_NAME}

install:
	go mod download
