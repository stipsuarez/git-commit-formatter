---
name: git-commit-formatter
description: Enforce standardized Git commit messages with branch-aware formatting. Use when creating any git commit to ensure consistency following BRANCH_NAME: description format. Automatically includes current branch identifier, validates message clarity, and provides helper scripts for streamlined workflows. Essential for team coordination, automated tools, and commit history readability.
license: MIT
metadata:
  author: Stip Suárez
  version: "1.0.1"
---

# Git Commit Formatter

Standardized commit messages that automatically include branch names, ensuring consistency and traceability across your development workflow.

## Format Convention

```
BRANCH_NAME: Clear, concise description of changes
```

**Example:** `SCRUM-2343: Fix login validation bug`

## Core Rules

| Rule | Details |
|------|---------|
| **Branch prefix** | Current Git branch name (e.g., `SCRUM-2343`, `feature/auth`) |
| **Separator** | Colon `:` and single space |
| **Description** | English, imperative mood (Add, Fix, Update not Added, Fixed, Updated) |
| **Length** | Under 72 characters |
| **Language** | English always |

## Quick Start

### Option 1: Manual Commit
```bash
git commit -m "BRANCH_NAME: Your description"
```

### Option 2: Using Helper Script
```powershell
.\scripts\git-commit-format.ps1 "Your description"
```
The script automatically extracts your branch name and validates format.

### Option 3: Shell Function (One-time Setup)
Add to PowerShell `$PROFILE`:
```powershell
function gcommit {
    param([string]$message)
    $branch = git branch --show-current
    git commit -m "$branch`: $message"
}
```
Then use: `gcommit "Your description"`

## Validation Checklist

- ✓ Starts with current branch name
- ✓ Includes colon and space after branch name
- ✓ Description in imperative mood
- ✓ Under 72 characters total
- ✓ Clear and specific (not vague)

## When to Use This Skill

Apply this skill when:
- Creating new commits
- Amending existing commits
- Setting team commit standards
- Integrating with automated tooling
- Training AI agents to write commits

## Additional Resources

- **Examples & Patterns**: See `references/examples.md`
- **Best Practices**: See `references/best-practices.md`
- **Troubleshooting**: See `references/troubleshooting.md`

