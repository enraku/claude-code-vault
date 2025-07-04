# Claude Code Configuration Vault

This repository contains standardized configurations, rules, and knowledge base for Claude Code usage across projects.

## 📁 Structure

```
claude-code-vault/
├── 00-Dashboard/           # Main dashboard and quick reference
├── 01-Global/             # Global CLAUDE.md configurations (EN/JP)
├── 02-Languages/          # Language-specific rules and guidelines
├── 03-Knowledge/          # Knowledge base and documentation
│   ├── MCP/              # Model Context Protocol guides
│   ├── Claude-Code/      # Claude Code best practices
│   ├── Development/      # General development knowledge
│   └── Tools/           # Tool-specific guides
├── 04-Templates/          # Project templates and boilerplates
├── 05-Archive/           # Archived and historical content
└── scripts/              # Setup and utility scripts
```

## 🚀 Quick Start

### 1. Clone this repository
```bash
git clone <repository-url>
cd claude-code-vault
```

### 2. Set up global CLAUDE.md
```bash
# Create symlink to global configuration
ln -s $(pwd)/01-Global/CLAUDE.md ~/.claude/CLAUDE.md
```

### 3. Install Obsidian plugins (optional)
- [Obsidian Git](https://github.com/denolehov/obsidian-git) - Auto sync with GitHub
- [Dataview](https://github.com/blacksmithgu/obsidian-dataview) - Dynamic queries
- [Templater](https://github.com/SilentVoid13/Templater) - Template management

### 4. Set up MCP integration
```bash
# Run MCP setup script
./scripts/setup-mcp.sh
```

## 📋 Usage

### Global Configuration
Use the global CLAUDE.md files for consistent behavior across all projects:
- `01-Global/CLAUDE.md` - **Primary configuration** (English, used by Claude Code)
- `01-Global/CLAUDE-ja.md` - **Documentation version** (Japanese translation for human reference)

**File Management**:
- `CLAUDE.md` is the authoritative source that Claude Code reads
- `CLAUDE-ja.md` should be kept in sync with the English version
- When updating configurations, modify both files to maintain consistency

### Language-Specific Rules
Reference language-specific guidelines in your project CLAUDE.md:
```markdown
# Project CLAUDE.md
[JavaScript Rules](https://github.com/your-org/claude-code-vault/blob/main/02-Languages/javascript-typescript.md)
```

### Knowledge Base Access
Use MCP integration to access knowledge base:
```
@obsidian-vault:read_file("03-Knowledge/MCP/MCP Guide.md")
```

## 🔧 MCP Integration

This vault supports Model Context Protocol for seamless integration with Claude Code:

- **File Access**: `@obsidian-vault:read_file(path)`
- **Search**: `@obsidian-vault:search(query)`
- **Git Operations**: `@git-vault:status()`

## 📖 Documentation

- [[00-Dashboard/Claude Code Dashboard]] - Main dashboard
- [[00-Dashboard/Quick Reference]] - Quick reference guide
- [[03-Knowledge/Claude-Code/Best Practices]] - CLAUDE.md best practices
- [[03-Knowledge/MCP/MCP Guide]] - MCP usage guide

## 🤝 Contributing

### Adding Knowledge from Other Projects

**Super Simple 3-Step Process** 🦈

#### Option 1: Global Commands (Recommended)
```bash
# Set up once
./scripts/setup-global-commands.sh
source ~/.bashrc

# Then from any project directory:
add-knowledge        # Create knowledge file
commit-knowledge     # Commit and push
```

#### Option 2: Direct Script
When in the vault directory:
1. **Create File**: `./scripts/add-knowledge.sh` (interactive setup)
2. **Fill Template**: Edit the created file, replace `[bracketed parts]`  
3. **Share**: `git add . && git commit -m "docs: add [name]" && git push`

See [[03-Knowledge/Development/knowledge-sharing-workflow]] for detailed workflow.

### General Contributions

1. Create a feature branch from `main`
2. Make your changes following the established structure
3. Update relevant documentation
4. Create a pull request

## 📝 Maintenance

### Regular Updates
- Review and update language-specific rules quarterly
- Add new knowledge entries as needed
- Archive outdated information to `05-Archive/`

### Obsidian Sync
If using Obsidian Git plugin, changes are automatically committed and pushed.

## 🔗 Related Links

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [MCP Protocol Specification](https://docs.anthropic.com/en/docs/claude-code/mcp)
- [Obsidian Documentation](https://help.obsidian.md/)

---

**Note**: This vault is designed to work with both direct file access and Obsidian for enhanced knowledge management.