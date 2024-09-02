package internals

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func GetEnvVariable(key string) string {
	err := godotenv.Load()
	if err != nil {
		log.Print("Error loading .env file, assuming this is PROD env")
	}
	return os.Getenv(key)
}
