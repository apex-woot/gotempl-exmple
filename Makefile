BINARY_NAME=dist

build:
	templ generate
	mkdir -p ./out
	GOARCH=amd64 GOOS=linux go build -o ./out/${BINARY_NAME} ./cmd/main.go
	ls -l ./out/${BINARY_NAME}

run: build
	./out/${BINARY_NAME}

install:
	go mod download
