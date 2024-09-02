package main

import (
	"go_fullstack/internals"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	// initialize config
	app := internals.Config{Router: router}

	gin.SetMode(gin.ReleaseMode)
	// routes
	app.Routes()

	router.Run(":4000")
}
