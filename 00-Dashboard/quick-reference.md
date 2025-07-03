# Quick Reference

## Claude Code Commands

### Basic Commands
- `/init` - Analyze codebase and create CLAUDE.md
- `/clear` - Clear conversation history
- `#` - Add instruction to CLAUDE.md
- `think` - Extended thinking (4k tokens)
- `think hard` - Deep thinking (10k tokens)
- `ultrathink` - Maximum thinking (32k tokens)

### MCP Commands
- `/mcp` - Manage MCP server connections
- `claude mcp add <name> <command>` - Add MCP server
- `claude mcp list` - List configured servers
- `@resource` - Reference MCP resource

## Obsidian Shortcuts

### Navigation
- `Ctrl/Cmd + O` - Quick switcher
- `Ctrl/Cmd + P` - Command palette
- `Ctrl/Cmd + Shift + F` - Global search
- `Ctrl/Cmd + G` - Graph view

### Editing
- `[[` - Create internal link
- `![[` - Embed note/image
- `#` - Create tag
- `---` - Insert horizontal rule

## Git Workflow

### Daily Sync
```bash
# Pull latest changes
git pull origin main

# Add changes
git add .

# Commit with message
git commit -m "docs: update knowledge base"

# Push to remote
git push origin main
```

### Branch Management
```bash
# Create feature branch
git checkout -b feature/new-knowledge

# Merge back to main
git checkout main
git merge feature/new-knowledge
```

---
Tags: #reference #quick-guide #shortcuts