# Java Rules

## Build Tools
- Check for `pom.xml` (Maven) or `build.gradle` (Gradle)
- Use existing build tool consistently
- Follow existing dependency management patterns
- Check for `mvnw` or `gradlew` wrapper scripts

## Project Structure
```
# Maven
src/
├── main/
│   ├── java/
│   │   └── com/company/project/
│   └── resources/
└── test/
    ├── java/
    │   └── com/company/project/
    └── resources/

# Gradle
src/
├── main/
│   ├── java/
│   │   └── com/company/project/
│   └── resources/
└── test/
    ├── java/
    │   └── com/company/project/
    └── resources/
```

## Common Commands
```bash
# Maven
mvn clean compile
mvn test
mvn clean package
mvn clean install
mvn dependency:tree

# Gradle
gradle build
gradle test
gradle clean build
gradle dependencies

# With wrappers
./mvnw clean package
./gradlew build
```

## Code Style
- Follow Google Java Style Guide or existing style
- Use consistent indentation (2 or 4 spaces)
- Use meaningful variable and method names
- Follow camelCase for variables and methods
- Use PascalCase for classes and interfaces

## Package and Import Organization
```java
// Package declaration
package com.company.project.service;

// Import organization
import java.util.List;
import java.util.Optional;
import java.time.LocalDateTime;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.company.project.model.User;
import com.company.project.repository.UserRepository;
```

## Exception Handling
```java
// Checked exceptions
public void readFile(String filename) throws IOException {
    try (BufferedReader reader = Files.newBufferedReader(Paths.get(filename))) {
        // Read file content
    } catch (IOException e) {
        logger.error("Failed to read file: {}", filename, e);
        throw e;
    }
}

// Custom exceptions
public class BusinessException extends Exception {
    private final String errorCode;
    
    public BusinessException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
    
    public String getErrorCode() {
        return errorCode;
    }
}

// Try-with-resources
public void processFile(String filename) {
    try (FileInputStream fis = new FileInputStream(filename);
         BufferedInputStream bis = new BufferedInputStream(fis)) {
        // Process file
    } catch (IOException e) {
        logger.error("Error processing file", e);
    }
}
```

## Testing with JUnit 5
```java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class UserServiceTest {
    
    private UserService userService;
    private UserRepository userRepository;
    
    @BeforeEach
    void setUp() {
        userRepository = mock(UserRepository.class);
        userService = new UserService(userRepository);
    }
    
    @Test
    @DisplayName("Should create user when valid data provided")
    void shouldCreateUserWhenValidData() {
        // Given
        User user = new User("John", "john@example.com");
        when(userRepository.save(any(User.class))).thenReturn(user);
        
        // When
        User result = userService.createUser("John", "john@example.com");
        
        // Then
        assertNotNull(result);
        assertEquals("John", result.getName());
        verify(userRepository).save(any(User.class));
    }
    
    @ParameterizedTest
    @ValueSource(strings = {"", " ", "invalid-email"})
    void shouldThrowExceptionForInvalidEmail(String email) {
        assertThrows(IllegalArgumentException.class, 
            () -> userService.createUser("John", email));
    }
}
```

## Spring Framework Patterns
```java
// Service layer
@Service
@Transactional
public class UserService {
    
    private final UserRepository userRepository;
    private final EmailService emailService;
    
    public UserService(UserRepository userRepository, EmailService emailService) {
        this.userRepository = userRepository;
        this.emailService = emailService;
    }
    
    public User createUser(CreateUserRequest request) {
        User user = new User(request.getName(), request.getEmail());
        User savedUser = userRepository.save(user);
        emailService.sendWelcomeEmail(savedUser);
        return savedUser;
    }
}

// REST Controller
@RestController
@RequestMapping("/api/users")
@Validated
public class UserController {
    
    private final UserService userService;
    
    public UserController(UserService userService) {
        this.userService = userService;
    }
    
    @PostMapping
    public ResponseEntity<UserResponse> createUser(@Valid @RequestBody CreateUserRequest request) {
        User user = userService.createUser(request);
        UserResponse response = UserResponse.from(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> getUser(@PathVariable Long id) {
        Optional<User> user = userService.findById(id);
        return user.map(u -> ResponseEntity.ok(UserResponse.from(u)))
                  .orElse(ResponseEntity.notFound().build());
    }
}

// Configuration
@Configuration
@EnableJpaRepositories
public class DatabaseConfig {
    
    @Bean
    @Primary
    public DataSource dataSource() {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:postgresql://localhost:5432/mydb");
        config.setUsername("user");
        config.setPassword("password");
        return new HikariDataSource(config);
    }
}
```

## JPA/Hibernate Patterns
```java
// Entity
@Entity
@Table(name = "users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    // Constructors, getters, setters
}

// Repository
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    Optional<User> findByEmail(String email);
    
    @Query("SELECT u FROM User u WHERE u.name LIKE %:name%")
    List<User> findByNameContaining(@Param("name") String name);
    
    @Modifying
    @Query("UPDATE User u SET u.active = false WHERE u.lastLogin < :date")
    int deactivateInactiveUsers(@Param("date") LocalDateTime date);
}
```

## Streams and Functional Programming
```java
import java.util.stream.Collectors;
import java.util.function.Predicate;

public class UserProcessor {
    
    public List<String> getActiveUserEmails(List<User> users) {
        return users.stream()
            .filter(User::isActive)
            .map(User::getEmail)
            .sorted()
            .collect(Collectors.toList());
    }
    
    public Map<String, List<User>> groupUsersByDomain(List<User> users) {
        return users.stream()
            .filter(user -> user.getEmail().contains("@"))
            .collect(Collectors.groupingBy(
                user -> user.getEmail().substring(user.getEmail().indexOf("@") + 1)
            ));
    }
    
    public Optional<User> findUserByPredicate(List<User> users, Predicate<User> predicate) {
        return users.stream()
            .filter(predicate)
            .findFirst();
    }
}
```

## Best Practices
- Use dependency injection instead of static methods
- Implement proper exception handling
- Use Optional for nullable values
- Write comprehensive unit tests
- Use meaningful variable and method names
- Implement proper logging with SLF4J
- Use builder pattern for complex objects
- Prefer composition over inheritance
- Use interfaces for abstraction
- Handle resources properly with try-with-resources

## Logging
```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class UserService {
    
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);
    
    public User createUser(String name, String email) {
        logger.info("Creating user with name: {} and email: {}", name, email);
        
        try {
            User user = new User(name, email);
            User savedUser = userRepository.save(user);
            logger.info("Successfully created user with ID: {}", savedUser.getId());
            return savedUser;
        } catch (Exception e) {
            logger.error("Failed to create user with name: {} and email: {}", name, email, e);
            throw new UserCreationException("Failed to create user", e);
        }
    }
}
```

---
Tags: #java #spring #junit #jpa #maven #gradle #testing #rules