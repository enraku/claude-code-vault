# Rust Rules

## Package Management
- Check `Cargo.toml` for project configuration
- Use `cargo` for all package management
- Follow semantic versioning for dependencies
- Use workspaces for multi-crate projects

## Project Structure
```
project/
├── src/
│   ├── main.rs          # Binary crate
│   ├── lib.rs           # Library crate
│   ├── modules/
│   └── bin/             # Additional binaries
├── tests/               # Integration tests
├── benches/             # Benchmarks
├── examples/            # Example code
├── Cargo.toml
├── Cargo.lock
└── README.md
```

## Common Commands
```bash
# Create new project
cargo new project-name
cargo new --lib library-name

# Build and run
cargo build
cargo run
cargo build --release

# Testing
cargo test
cargo test --lib
cargo test integration_test

# Linting and formatting
cargo fmt
cargo clippy
cargo clippy -- -D warnings

# Documentation
cargo doc --open

# Package management
cargo add dependency-name
cargo update
cargo check
```

## Error Handling
```rust
// Result type usage
fn read_file(path: &str) -> Result<String, std::io::Error> {
    std::fs::read_to_string(path)
}

// Error propagation with ?
fn process_file(path: &str) -> Result<Vec<String>, Box<dyn std::error::Error>> {
    let content = read_file(path)?;
    let lines: Vec<String> = content.lines().map(|s| s.to_string()).collect();
    Ok(lines)
}

// Custom error types
#[derive(Debug)]
enum ProcessError {
    IoError(std::io::Error),
    ParseError(String),
}

impl std::fmt::Display for ProcessError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            ProcessError::IoError(e) => write!(f, "IO error: {}", e),
            ProcessError::ParseError(msg) => write!(f, "Parse error: {}", msg),
        }
    }
}

impl std::error::Error for ProcessError {}
```

## Memory Management
```rust
// Ownership patterns
fn take_ownership(s: String) {
    println!("{}", s);
    // s is dropped here
}

fn borrow_immutable(s: &String) {
    println!("{}", s);
    // s is not dropped, original owner retains ownership
}

fn borrow_mutable(s: &mut String) {
    s.push_str(" modified");
}

// Lifetimes
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Smart pointers
use std::rc::Rc;
use std::cell::RefCell;

let shared_data = Rc::new(RefCell::new(vec![1, 2, 3]));
let reference1 = Rc::clone(&shared_data);
let reference2 = Rc::clone(&shared_data);
```

## Pattern Matching
```rust
// Match expressions
fn process_option(opt: Option<i32>) -> i32 {
    match opt {
        Some(value) => value * 2,
        None => 0,
    }
}

// Match with guards
fn categorize_number(n: i32) -> &'static str {
    match n {
        x if x < 0 => "negative",
        0 => "zero",
        x if x > 0 && x <= 10 => "small positive",
        _ => "large positive",
    }
}

// Destructuring
struct Point { x: i32, y: i32 }

fn analyze_point(point: Point) {
    match point {
        Point { x: 0, y: 0 } => println!("Origin"),
        Point { x: 0, y } => println!("On Y-axis at {}", y),
        Point { x, y: 0 } => println!("On X-axis at {}", x),
        Point { x, y } => println!("Point at ({}, {})", x, y),
    }
}
```

## Traits and Generics
```rust
// Trait definition
trait Drawable {
    fn draw(&self);
    fn area(&self) -> f64;
}

// Trait implementation
struct Circle {
    radius: f64,
}

impl Drawable for Circle {
    fn draw(&self) {
        println!("Drawing circle with radius {}", self.radius);
    }
    
    fn area(&self) -> f64 {
        std::f64::consts::PI * self.radius * self.radius
    }
}

// Generic functions
fn print_drawable<T: Drawable>(item: &T) {
    item.draw();
    println!("Area: {}", item.area());
}

// Where clause for complex bounds
fn complex_function<T, U>(t: T, u: U) -> String
where
    T: std::fmt::Display + Clone,
    U: std::fmt::Debug + Copy,
{
    format!("T: {}, U: {:?}", t, u)
}
```

## Concurrency
```rust
use std::thread;
use std::sync::{Arc, Mutex};
use std::sync::mpsc;

// Thread spawning
fn spawn_threads() {
    let handles: Vec<_> = (0..3)
        .map(|i| {
            thread::spawn(move || {
                println!("Thread {} is running", i);
            })
        })
        .collect();
    
    for handle in handles {
        handle.join().unwrap();
    }
}

// Shared state with Arc<Mutex<T>>
fn shared_counter() {
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];
    
    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            let mut num = counter.lock().unwrap();
            *num += 1;
        });
        handles.push(handle);
    }
    
    for handle in handles {
        handle.join().unwrap();
    }
}

// Channels for message passing
fn message_passing() {
    let (tx, rx) = mpsc::channel();
    
    thread::spawn(move || {
        let vals = vec![1, 2, 3, 4, 5];
        for val in vals {
            tx.send(val).unwrap();
            thread::sleep(std::time::Duration::from_millis(100));
        }
    });
    
    for received in rx {
        println!("Got: {}", received);
    }
}
```

## Testing
```rust
// Unit tests
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_addition() {
        assert_eq!(add(2, 3), 5);
    }
    
    #[test]
    fn test_division() {
        assert!(divide(10.0, 3.0).is_some());
        assert!(divide(10.0, 0.0).is_none());
    }
    
    #[test]
    #[should_panic(expected = "divide by zero")]
    fn test_panic() {
        panic_divide(10, 0);
    }
}

// Integration tests (in tests/ directory)
// tests/integration_test.rs
use my_crate::*;

#[test]
fn integration_test() {
    let result = public_function();
    assert_eq!(result, expected_value);
}

// Benchmarks (in benches/ directory)
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn fibonacci_benchmark(c: &mut Criterion) {
    c.bench_function("fib 20", |b| b.iter(|| fibonacci(black_box(20))));
}

criterion_group!(benches, fibonacci_benchmark);
criterion_main!(benches);
```

## Best Practices
- Use `rustfmt` for consistent formatting
- Run `clippy` for linting and best practices
- Prefer ownership over borrowing when simple
- Use `Result` for recoverable errors, `panic!` for unrecoverable
- Write comprehensive tests for public APIs
- Use meaningful variable and function names
- Leverage the type system for correctness
- Document public APIs with `///` comments
- Use `cargo-audit` for security vulnerability scanning

## Async/Await (with tokio)
```rust
// Add to Cargo.toml:
// tokio = { version = "1.0", features = ["full"] }

use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let response = reqwest::get("https://api.example.com/data").await?;
    let body = response.text().await?;
    println!("Response: {}", body);
    Ok(())
}

// Async functions
async fn fetch_data(url: &str) -> Result<String, reqwest::Error> {
    let response = reqwest::get(url).await?;
    response.text().await
}

// Concurrent async operations
async fn fetch_multiple() -> Result<Vec<String>, Box<dyn std::error::Error>> {
    let urls = vec![
        "https://api.example.com/data1",
        "https://api.example.com/data2",
        "https://api.example.com/data3",
    ];
    
    let futures: Vec<_> = urls
        .into_iter()
        .map(|url| fetch_data(url))
        .collect();
    
    let results = futures::future::try_join_all(futures).await?;
    Ok(results)
}
```

---
Tags: #rust #cargo #ownership #concurrency #async #testing #rules