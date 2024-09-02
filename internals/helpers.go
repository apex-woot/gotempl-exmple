package internals

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func GetEnvVariable(key string) string {
	if _, exists := os.LookupEnv("RAILWAY_ENVIRONMENT"); exists == false {
		// your godotenv code here
		err := godotenv.Load()
		if err != nil {
			log.Print("Error loading .env file, assuming this is PROD env")
		}
	}
	return os.Getenv(key)
}
