# Go Rules

## Module Management
- Check `go.mod` for module name and Go version
- Use `go mod tidy` to clean up dependencies
- Follow semantic versioning for releases
- Use `go.work` for multi-module workspaces

## Package Management
```bash
# Initialize module
go mod init module-name

# Add dependency
go get package-name

# Update dependencies
go mod tidy
go get -u ./...

# Clean module cache
go clean -modcache
```

## Code Style
- Use `gofmt` or `goimports` for formatting
- Follow Go naming conventions (camelCase, PascalCase)
- Use `golint` or `staticcheck` for linting
- Keep functions small and focused

## Project Structure
```
project/
├── cmd/                 # Main applications
│   └── myapp/
│       └── main.go
├── internal/            # Private application code
│   ├── handlers/
│   ├── services/
│   └── models/
├── pkg/                 # Public library code
├── api/                 # API definitions (OpenAPI, protobuf)
├── configs/             # Configuration files
├── scripts/             # Build and deployment scripts
├── test/                # Test data and tools
├── go.mod
├── go.sum
└── README.md
```

## Error Handling
```go
// Always handle errors explicitly
func processData() error {
    data, err := fetchData()
    if err != nil {
        return fmt.Errorf("failed to fetch data: %w", err)
    }
    
    if err := validateData(data); err != nil {
        return fmt.Errorf("data validation failed: %w", err)
    }
    
    return nil
}

// Custom error types
type ValidationError struct {
    Field string
    Value interface{}
}

func (e ValidationError) Error() string {
    return fmt.Sprintf("validation failed for field %s with value %v", e.Field, e.Value)
}
```

## Testing
```go
// Unit tests
func TestProcessData(t *testing.T) {
    tests := []struct {
        name    string
        input   string
        want    string
        wantErr bool
    }{
        {"valid input", "test", "processed", false},
        {"invalid input", "", "", true},
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got, err := processData(tt.input)
            if (err != nil) != tt.wantErr {
                t.Errorf("processData() error = %v, wantErr %v", err, tt.wantErr)
                return
            }
            if got != tt.want {
                t.Errorf("processData() = %v, want %v", got, tt.want)
            }
        })
    }
}

// Benchmarks
func BenchmarkProcessData(b *testing.B) {
    for i := 0; i < b.N; i++ {
        processData("test input")
    }
}
```

## Common Commands
```bash
# Run application
go run main.go
go run cmd/myapp/main.go

# Build application
go build
go build -o myapp cmd/myapp/main.go

# Test
go test ./...
go test -v ./...
go test -cover ./...
go test -bench=. ./...

# Format and lint
gofmt -w .
goimports -w .
golint ./...
staticcheck ./...

# Generate code
go generate ./...
```

## Concurrency Patterns
```go
// Goroutines and channels
func processItems(items []string) <-chan string {
    results := make(chan string, len(items))
    
    for _, item := range items {
        go func(item string) {
            result := processItem(item)
            results <- result
        }(item)
    }
    
    return results
}

// Worker pool pattern
func workerPool(jobs <-chan Job, results chan<- Result) {
    const numWorkers = 3
    var wg sync.WaitGroup
    
    for i := 0; i < numWorkers; i++ {
        wg.Add(1)
        go func() {
            defer wg.Done()
            for job := range jobs {
                result := processJob(job)
                results <- result
            }
        }()
    }
    
    go func() {
        wg.Wait()
        close(results)
    }()
}

// Context for cancellation
func processWithContext(ctx context.Context, data string) error {
    select {
    case <-ctx.Done():
        return ctx.Err()
    default:
        // Process data
        return nil
    }
}
```

## HTTP Server Patterns
```go
// Using standard library
func main() {
    mux := http.NewServeMux()
    mux.HandleFunc("/api/users", handleUsers)
    
    server := &http.Server{
        Addr:    ":8080",
        Handler: mux,
        Timeout: 30 * time.Second,
    }
    
    log.Fatal(server.ListenAndServe())
}

// Middleware pattern
func loggingMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        start := time.Now()
        next.ServeHTTP(w, r)
        log.Printf("%s %s %v", r.Method, r.URL.Path, time.Since(start))
    })
}
```

## Database Patterns
```go
// Using database/sql
func getUserByID(db *sql.DB, id int) (*User, error) {
    var user User
    query := "SELECT id, name, email FROM users WHERE id = $1"
    
    err := db.QueryRow(query, id).Scan(&user.ID, &user.Name, &user.Email)
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, fmt.Errorf("user not found")
        }
        return nil, fmt.Errorf("failed to query user: %w", err)
    }
    
    return &user, nil
}

// Transaction handling
func transferMoney(db *sql.DB, fromID, toID int, amount decimal.Decimal) error {
    tx, err := db.Begin()
    if err != nil {
        return fmt.Errorf("failed to begin transaction: %w", err)
    }
    defer tx.Rollback()
    
    // Perform operations
    if err := debitAccount(tx, fromID, amount); err != nil {
        return err
    }
    
    if err := creditAccount(tx, toID, amount); err != nil {
        return err
    }
    
    return tx.Commit()
}
```

## Best Practices
- Keep interfaces small and focused
- Use composition over inheritance
- Handle errors explicitly, don't ignore them
- Use context.Context for cancellation and timeouts
- Write tests for all public functions
- Use meaningful variable and function names
- Avoid global variables
- Use channels for communication between goroutines

---
Tags: #go #golang #concurrency #http #database #testing #rules