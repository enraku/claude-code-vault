# Obsidian MCP Integration

## Overview

This document outlines the integration between Obsidian and Claude Code using Model Context Protocol (MCP).

## MCP Server Setup

### 1. Obsidian File System Server

```bash
# Add Obsidian vault as MCP server
claude mcp add obsidian-vault file:///path/to/claude-code-vault
```

### 2. Git Integration Server

```bash
# Add git MCP server for version control
claude mcp add git-vault --transport stdio -- git-mcp-server /path/to/claude-code-vault
```

### 3. Markdown Processing Server

```bash
# Add markdown processing capabilities
claude mcp add markdown-processor --transport http -- markdown-mcp-server
```

## Usage Examples

### Accessing Vault Content

```
# Reference a specific note
@obsidian-vault://Claude Code Dashboard.md

# Search across vault
@obsidian-vault:search("MCP guide")

# List recent notes
@obsidian-vault:recent(7)
```

### Git Operations

```
# Check vault status
@git-vault:status

# Commit changes
@git-vault:commit("docs: add new knowledge entry")

# View history
@git-vault:log(10)
```

### Markdown Operations

```
# Convert note to different format
@markdown-processor:convert("note.md", "html")

# Extract metadata
@markdown-processor:metadata("note.md")

# Generate table of contents
@markdown-processor:toc("note.md")
```

## Automation Workflows

### 1. Auto-sync on Changes

```bash
# Set up file watcher for auto-commit
claude mcp add file-watcher --transport stdio -- \
  file-watcher /path/to/claude-code-vault \
  --on-change "git add . && git commit -m 'auto: sync changes'"
```

### 2. Knowledge Extraction

```
# Extract knowledge from conversations
/mcp__obsidian__extract_knowledge "Create note from this conversation"
```

### 3. Template Generation

```
# Generate new note from template
/mcp__obsidian__new_note "Language Rules" --template "language-rule"
```

## Benefits

1. **Seamless Access**: Claude Code can directly read/write Obsidian notes
2. **Version Control**: Automatic git integration for change tracking
3. **Knowledge Mining**: Extract insights from conversations into structured notes
4. **Template Automation**: Generate consistent documentation structure
5. **Cross-Reference**: Automatic linking between related concepts

## Troubleshooting

### Common Issues

1. **Path Resolution**: Ensure absolute paths are used for vault location
2. **Permissions**: Verify Claude Code has read/write access to vault
3. **Git Conflicts**: Use proper branching strategy for concurrent edits

### Debug Commands

```bash
# Test MCP connection
claude mcp test obsidian-vault

# List available resources
claude mcp resources obsidian-vault

# Check server logs
claude mcp logs obsidian-vault
```

---
Tags: #mcp #obsidian #integration #automation