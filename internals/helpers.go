package internals

import (
	"fmt"
	"os"

	"github.com/joho/godotenv"
)

func GetEnvVariable(key string) string {
	env := godotenv.Load()
	if env != nil {
		fmt.Println("cannot find environment variables from file")
	}
	return os.Getenv(key)
}
