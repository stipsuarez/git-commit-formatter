---
name: git-commit-formatter
description: Guide for creating properly formatted git commit messages that follow the BRANCH_NAME: description convention. This skill helps ensure all commits include the current branch identifier at the beginning, followed by a concise description of the changes made.
license: MIT
metadata:
  author: user
  version: "1.0.0"
---

# Git Commit Formatter

This skill guides the creation of properly formatted git commit messages following a standardized convention that includes branch names as commit prefixes.

## Commit Message Convention

All commits must follow this format:

```
BRANCH_NAME: Short, descriptive summary of the changes
```

### Format Rules

1. **Branch Name**: The current Git branch name (e.g., `SCRUM-2343`, `feature/auth-flow`, `bugfix/login-validation`)
2. **Colon**: A colon `:` separates the branch name from the description
3. **Space**: One space after the colon
4. **Description**: A clear, concise English description of what changed (imperative mood preferred)
5. **Length**: Keep descriptions under 72 characters for terminal display
6. **Language**: Always in English

### Examples

Valid commit messages:
- `SCRUM-2343: Fix login validation bug`
- `feature/auth: Add two-factor authentication support`
- `bugfix/api: Handle null response in payment endpoint`
- `release/1.2.0: Bump version and update changelog`
- `hotfix/critical: Revert broken deployment`

## How to Use This Skill

When you need to create a git commit:

1. **Determine your current branch**: Run `git branch --show-current` or check your Git interface
2. **Describe the changes**: Think of what changed in 1-2 sentences (imperative mood)
3. **Combine them**: Format as `BRANCH_NAME: description`
4. **Create the commit**: Use `git commit -m "BRANCH_NAME: description"`

## Format Validation Checklist

✓ Does it start with the current branch name?
✓ Is there a colon and space after the branch name?
✓ Is the description in English?
✓ Is it written in imperative mood (e.g., "Add", "Fix", "Refactor" vs "Added", "Fixed", "Refactored")?
✓ Is the total message under 72 characters?
✓ Does it clearly explain WHAT changed and WHY (briefly)?

## Git Integration

### Quick Reference Commands

1. **Check current branch**: `git branch --show-current`
2. **Create commit with formatted message**: `git commit -m "BRANCH_NAME: Your message"`
3. **Amend last commit**: `git commit --amend -m "BRANCH_NAME: Corrected message"`
4. **Commit all changes**: `git add . && git commit -m "BRANCH_NAME: Your message"`

### Shell Alias (Optional)

To simplify the workflow, add this alias to your shell configuration:

```bash
# For PowerShell ($PROFILE):
function gcommit {
    param([string]$message)
    $branch = git branch --show-current
    git commit -m "$branch`:`$message"
}

# For Bash/Zsh (.bashrc or .zshrc):
alias gcommit='git commit -m "$(git branch --show-current): "'
```

Usage: `gcommit "Fix login validation bug"`

## When This Skill Applies

Use this skill when:
- Creating new git commits
- Amending existing commits
- Following team commit message standards
- Ensuring consistency across the repository
- Using tools that generate or validate commit messages

