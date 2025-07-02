#!/bin/bash

# Obsidian-Claude Code MCP Setup Script

set -e

VAULT_PATH="$(pwd)/claude-code-vault"
echo "Setting up MCP integration for vault: $VAULT_PATH"

# Check if claude command exists
if ! command -v claude &> /dev/null; then
    echo "Error: Claude Code CLI not found. Please install it first."
    exit 1
fi

# Add Obsidian vault as file system MCP server
echo "Adding Obsidian vault MCP server..."
claude mcp add obsidian-vault \
  --transport stdio \
  -- node -e "
const fs = require('fs');
const path = require('path');

const VAULT_PATH = '$VAULT_PATH';

// Simple MCP server for Obsidian vault
process.stdin.on('data', (data) => {
  try {
    const request = JSON.parse(data.toString());
    
    if (request.method === 'list_files') {
      // List all markdown files in vault
      const files = [];
      function scanDir(dir) {
        const items = fs.readdirSync(dir);
        items.forEach(item => {
          const fullPath = path.join(dir, item);
          const stat = fs.statSync(fullPath);
          if (stat.isDirectory() && !item.startsWith('.')) {
            scanDir(fullPath);
          } else if (item.endsWith('.md')) {
            files.push(path.relative(VAULT_PATH, fullPath));
          }
        });
      }
      scanDir(VAULT_PATH);
      
      process.stdout.write(JSON.stringify({
        id: request.id,
        result: { files }
      }) + '\n');
    }
    
    if (request.method === 'read_file') {
      const filePath = path.join(VAULT_PATH, request.params.path);
      const content = fs.readFileSync(filePath, 'utf8');
      
      process.stdout.write(JSON.stringify({
        id: request.id,
        result: { content }
      }) + '\n');
    }
    
    if (request.method === 'write_file') {
      const filePath = path.join(VAULT_PATH, request.params.path);
      const dir = path.dirname(filePath);
      
      // Ensure directory exists
      fs.mkdirSync(dir, { recursive: true });
      fs.writeFileSync(filePath, request.params.content);
      
      process.stdout.write(JSON.stringify({
        id: request.id,
        result: { success: true }
      }) + '\n');
    }
    
  } catch (error) {
    process.stdout.write(JSON.stringify({
      id: request.id,
      error: { message: error.message }
    }) + '\n');
  }
});
"

echo "MCP server 'obsidian-vault' added successfully!"

# Add Git MCP server for version control
echo "Adding Git MCP server..."
claude mcp add git-vault \
  --transport stdio \
  --env GIT_DIR="$VAULT_PATH/.git" \
  -- git-mcp-server "$VAULT_PATH"

echo "MCP server 'git-vault' added successfully!"

# Test the connection
echo "Testing MCP connections..."
claude mcp list

echo "MCP setup completed successfully!"
echo ""
echo "Usage examples:"
echo "  @obsidian-vault:list_files() - List all markdown files"
echo "  @obsidian-vault:read_file('path/to/file.md') - Read a specific file"
echo "  @git-vault:status() - Check git status"
echo ""
echo "You can now use these MCP servers in Claude Code!"