package main

import (
	"fmt"
	"go_fullstack/internals"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	// initialize config
	app := internals.Config{Router: router}

	gin.SetMode(gin.ReleaseMode)
	// routes
	app.Routes()
	port := os.Getenv("PORT")

	if port == "" {
		port = "8080"
	} else {
		port = "4000"
	}

	router.Run(fmt.Sprintf(":%s", port))
}
