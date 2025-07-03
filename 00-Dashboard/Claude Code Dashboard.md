# Claude Code Dashboard

## 🎯 Quick Access

### Global Configuration
- [[01-Global/CLAUDE|Global CLAUDE.md (English)]]
- [[01-Global/CLAUDE-ja|Global CLAUDE.md (Japanese)]]

### Language Rules
- [[02-Languages/JavaScript-TypeScript|JavaScript/TypeScript]]
- [[02-Languages/Python|Python]]
- [[02-Languages/Go|Go]]
- [[02-Languages/Rust|Rust]]
- [[02-Languages/Java|Java]]

### Knowledge Base
- [[03-Knowledge/MCP/MCP Guide|MCP Guide]]
- [[03-Knowledge/Claude-Code/Best Practices|Claude Code Best Practices]]
- [[03-Knowledge/Development/Git Workflows|Git Workflows]]

## 📊 Recent Updates

```dataview
TABLE file.mtime AS "Last Modified"
FROM ""
WHERE file.mtime > date(today) - dur(7 days)
SORT file.mtime DESC
LIMIT 10
```

## 🏷️ Tag Overview

```dataview
TABLE length(rows) AS "Count"
FROM ""
FLATTEN file.etags AS tag
GROUP BY tag
SORT length(rows) DESC
```

## 🔗 Orphaned Notes

```dataview
TABLE
FROM ""
WHERE length(file.inlinks) = 0 AND length(file.outlinks) = 0
```

---
Tags: #dashboard #claude-code #main