package internals

import (
	"os"
)

func GetEnvVariable(key string) string {
	// env := godotenv.Load()
	// if env != nil {
	// 	fmt.Println("cannot find environment variables from file")
	// }
	return os.Getenv(key)
}
