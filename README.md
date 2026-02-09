# Git Commit Formatter Skill

A standardized Git commit message skill that enforces consistent, branch-aware commit formatting across your development workflow.

## Overview

The Git Commit Formatter skill ensures all commits follow a standardized convention that includes the current Git branch name as a prefix, followed by a concise description of the changes. This approach provides several benefits:

- **Branch tracking**: Automatically includes the branch identifier in every commit message
- **Consistency**: Enforces a uniform commit message format across teams and projects
- **Traceability**: Makes it easy to correlate commits with tickets, features, or bug fixes
- **Readability**: Clear, imperative-mood descriptions make commit history more digestible
- **Automation-friendly**: Enables scripting and automated tools to parse commit messages

## Format Convention

All commits follow this standardized format:

```
BRANCH_NAME: Short, descriptive summary of the changes
```

### Format Rules

| Aspect | Rule |
|--------|------|
| **Branch Name** | Current Git branch name (e.g., `SCRUM-2343`, `feature/auth-flow`) |
| **Separator** | Colon `:` followed by a space |
| **Description** | Clear English text describing what changed (imperative mood) |
| **Length** | Keep under 72 characters for optimal terminal display |
| **Language** | Always use English |

## Examples

### ✅ Valid Commits

```
SCRUM-2343: Fix login validation bug
feature/auth: Add two-factor authentication support
bugfix/api: Handle null response in payment endpoint
release/1.2.0: Bump version and update changelog
hotfix/critical: Revert broken deployment
maintenance/deps: Update npm dependencies
docs/api: Add authentication endpoints documentation
```

### ❌ Invalid Commits (Don't Do This)

```
Fixed login bug                          # Missing branch name
SCRUM-2343: Fixed login bug              # Wrong tense (past not imperative)
SCRUM-2343:Fix login bug                 # Missing space after colon
feature/auth:Add auth: Support feature   # Confusing format
```

## Usage

### Option 1: Manual Commit Creation

1. Identify your current branch: `git branch --show-current`
2. Create commit with format: `git commit -m "BRANCH_NAME: description"`

**Example:**
```bash
git commit -m "SCRUM-2343: Fix login validation bug"
```

### Option 2: Using the Provided Script

Run the PowerShell helper script:

```powershell
.\scripts\git-commit-format.ps1 "Fix login validation bug"
```

The script automatically:
- Fetches your current branch name
- Validates the message format
- Warns if message exceeds 72 characters
- Creates the commit with proper formatting

### Option 3: Terminal Alias (One-time Setup)

Add to your PowerShell profile (`$PROFILE`):

```powershell
function gcommit {
    param([string]$message)
    $branch = git branch --show-current
    git commit -m "$branch`: $message"
}
```

Then use: `gcommit "Your commit message"`

## Features

✅ **Automated Branch Detection** - Automatically includes current branch name  
✅ **Message Validation** - Ensures proper format and length  
✅ **Clear Examples** - Reference implementations for common scenarios  
✅ **Length Warnings** - Alerts when messages exceed recommended length  
✅ **Helper Script** - PowerShell script for streamlined workflow  
✅ **Team-Friendly** - Enforces consistency across development teams

## File Structure

```
git-commit-formatter/
├── SKILL.md                         # Primary skill documentation
├── scripts/
│   └── git-commit-format.ps1       # PowerShell helper script
└── README.md                        # This file
```

## Configuration

This skill works with any Git repository. No additional configuration is required beyond standard Git setup.

### Git Config (Optional)

Configure your Git user globally:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Or locally for a specific repository:

```bash
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

## Integration with AI Agents

This skill is designed to work with AI coding agents and assistants. When used with Claude or other AI agents, this skill provides:

- Clear guidelines for commit message generation
- Consistent formatting rules for automated commits
- Branch-aware commit creation
- Quality standards for commit messages

## Best Practices

1. **Use imperative mood**: "Add feature" not "Added feature"
2. **Be specific**: "Fix null pointer in payment handler" not "Fix bug"
3. **Keep it concise**: Aim for under 50 characters, max 72
4. **One change per commit**: If your message needs "and," consider splitting
5. **Reference tickets**: Use branch names that include ticket numbers (e.g., `SCRUM-2343`)

## Troubleshooting

### Issue: Branch name contains special characters
**Solution**: Git handles most characters in branch names. Use hyphens or forward slashes as separators (e.g., `feature/auth`, `bugfix/api-null-handling`).

### Issue: Commit message is too long
**Solution**: Aim for 72 characters maximum. The script warns when exceeded. Consider splitting or abbreviating.

### Issue: Wrong branch name in commit
**Solution**: Switch to the correct branch before committing: `git checkout BRANCH_NAME` then commit.

## Contributing

To improve this skill, submit suggestions or create a pull request at:  
https://github.com/stipsuarez/git-commit-formatter

## Author

**Stip Suárez**

## License

MIT License - See LICENSE file for details

---

**Last Updated:** February 2026  
**Version:** 1.0.0
