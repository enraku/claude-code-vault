# CLAUDE.md - Global Configuration

This file provides global guidance to Claude Code across all projects.

## General Principles

- **Be concise**: Provide clear, actionable responses without unnecessary explanation
- **Follow existing patterns**: Always examine codebase conventions before making changes  
- **Security first**: Never expose secrets, keys, or sensitive information
- **Test-driven approach**: Write tests before implementation when possible

## Code Quality Standards

- Use consistent formatting and linting
- Write self-documenting code with meaningful names
- Follow language-specific best practices
- Implement proper error handling
- Add comments only when necessary for complex logic

## Workflow Practices

### Before Coding
1. Read relevant files to understand context
2. Check existing patterns and conventions
3. Plan implementation approach
4. Use "think" for complex problems requiring analysis

### During Development
- Make incremental commits with clear messages
- Run tests and linting after changes
- Verify functionality manually when appropriate
- Course correct early if approach isn't working

### Common Commands to Check
- `npm run test` / `pytest` / `go test`
- `npm run lint` / `flake8` / `cargo clippy`
- `npm run build` / `make` / `cargo build`
- `npm run dev` / development server commands

## File Organization

### Always Prefer
- Editing existing files over creating new ones
- Using established project structure
- Following existing naming conventions
- Reusing existing utilities and components

### Avoid Creating
- Duplicate functionality
- Unnecessary documentation files (unless requested)
- Files that break project conventions
- Complex abstractions for simple problems

## Language-Specific Guidelines

### JavaScript/TypeScript
- Use existing package manager (npm/yarn/pnpm)
- Follow TypeScript strict mode when enabled
- Use existing state management patterns
- Prefer functional components in React

### Python
- Follow PEP 8 style guidelines
- Use virtual environments
- Prefer type hints when available
- Use existing logging and error handling patterns

### Go
- Follow Go formatting standards (gofmt)
- Use existing module structure
- Handle errors explicitly
- Write simple, readable code

### Rust
- Follow rustfmt formatting
- Use cargo for package management
- Handle Result types properly
- Prefer ownership over borrowing when simple

### Java
- Follow Google Java Style Guide
- Use Maven/Gradle as configured
- Implement proper exception handling
- Use existing frameworks and patterns

## Communication Style

- Answer directly without preamble
- Keep responses under 4 lines unless detail requested
- Use bullet points for multiple items
- Provide file paths with line numbers when referencing code

## Problem-Solving Approach

1. **Explore**: Use search tools to understand codebase
2. **Plan**: Break down complex tasks
3. **Implement**: Follow established patterns
4. **Verify**: Test and validate changes
5. **Document**: Update relevant documentation if needed

## Error Handling

- Read error messages carefully
- Check common issues first (dependencies, permissions, syntax)
- Use appropriate debugging tools for the language/framework
- Provide specific error context when asking for help

## Efficiency Tips

- Use batch operations for multiple related changes
- Leverage existing tooling and scripts
- Avoid reinventing functionality that already exists
- Focus on the specific problem at hand

## MCP Integration

When available, use MCP servers for:
- File system operations: `@obsidian-vault:read_file(path)`
- Git operations: `@git-vault:status()`
- Knowledge base access: `@knowledge-base:search(query)`

---
Tags: #claude-code #global-config #best-practices