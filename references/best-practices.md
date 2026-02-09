# Best Practices

## Writing Effective Commit Messages

### 1. Use Imperative Mood

Commits describe what the code **will do**, not what it **did**.

✓ **Correct:**
```
feature/auth: Add two-factor authentication
bugfix/api: Fix null pointer exception
maintenance/deps: Update React to v18
```

✗ **Incorrect:**
```
feature/auth: Added two-factor authentication
bugfix/api: Fixed null pointer exception
maintenance/deps: Updated React to v18
```

### 2. Be Specific and Descriptive

Vague commits make history hard to understand. Include what changed and why.

✓ **Specific:**
```
bugfix/api: Handle null response from payment gateway
feature/dashboard: Add export to CSV functionality
```

✗ **Vague:**
```
bugfix/api: Fix bug
feature/dashboard: Add feature
```

### 3. Keep It Concise

Aim for commits under 50 characters, stay within 72 character limit for proper terminal display.

✓ **Concise:** `performance/cache: Add Redis caching for user queries` (52 chars)
✗ **Too Long:** `performance/cache: This commit adds Redis caching to improve performance of user queries by implementing a caching layer` (126 chars)

### 4. One Logical Change Per Commit

If your commit message contains "and", consider if you should split it.

✓ **Separate concerns:**
```
feature/auth: Add password reset endpoint
docs/auth: Document password reset API
```

✗ **Mixed concerns:**
```
feature/auth: Add password reset endpoint and document API
```

### 5. Reference Tickets in Branch Names

Use ticket/issue IDs in branch names for traceability.

✓ **Traceable:**
```
SCRUM-2343: Update user profile page
JIRA-456: Fix authentication timeout
Issue-789: Add dark mode support
```

✗ **Not traceable:**
```
auth: Update user profile page
fix: Fix authentication timeout
feature: Add dark mode support
```

## Team Coordination

### Establish Branch Naming Convention

Document your team's branch naming convention:

```
Feature:      feature/TICKET-ID or feature/description
Bugfix:       bugfix/TICKET-ID or bugfix/issue-description
Release:      release/VERSION
Hotfix:       hotfix/brief-description
Maintenance:  maintenance/area-of-work
```

### Enable CI/CD Automation

Parse commit messages programmatically:

```bash
# Extract branch name
BRANCH=$(git branch --show-current)

# Extract ticket number
TICKET=$(echo $BRANCH | grep -oE '[A-Z]+-[0-9]+')

# Use in automation
curl -X POST "https://api.jira.com/tickets/$TICKET" \
  -d "Updated by commit: $COMMIT_MESSAGE"
```

### Document Team Standards

Create a CONTRIBUTING.md in your repository:

```markdown
## Commit Message Format

All commits must follow: `BRANCH_NAME: Description`

### Examples
- `SCRUM-2343: Fix login validation`
- `feature/api: Add user endpoints`

### Rules
1. Use imperative mood (Add, not Added)
2. Keep under 72 characters
3. Include ticket ID when applicable
4. Be specific about what changed
```

## Integration with Tools

### GitHub Actions

Validate commit format in CI:

```yaml
name: Validate Commits

on: [pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Validate commit format
        run: |
          git log --format='%B' ${{ github.event.pull_request.base.sha }}..${{ github.event.pull_request.head.sha }} | \
          grep -E '^[a-zA-Z0-9/_-]+: ' || exit 1
```

### Pre-commit Hook

Validate locally before pushing:

```bash
#!/bin/bash
# .git/hooks/pre-commit

BRANCH=$(git branch --show-current)
COMMIT_MSG=$(git diff --cached --name-only | head -1)

if [[ ! "$COMMIT_MSG" =~ ^${BRANCH}: ]]; then
  echo "Error: Commit must start with: $BRANCH:"
  exit 1
fi
```

### IDE Integration

Configure IDE settings for commit message templates:

**VS Code (.vscode/settings.json):**
```json
{
  "git.inputValidationLength": 72,
  "git.inputValidationSubjectLength": 72
}
```

## Workflow Examples

### Feature Development Workflow

```bash
# 1. Create feature branch
git checkout -b feature/SCRUM-2343

# 2. Make changes
# ... edit files ...

# 3. Commit with proper format
git add .
git commit -m "feature/SCRUM-2343: Implement new authentication method"

# 4. Push
git push origin feature/SCRUM-2343

# 5. Create pull request
gh pr create --title "feature/SCRUM-2343: Implement new authentication method"
```

### Hotfix Workflow (Critical Production Issue)

```bash
# 1. Create hotfix branch from main
git checkout -b hotfix/critical-security-patch main

# 2. Fix critical issue
# ... emergency fix ...

# 3. Commit immediately
git add .
git commit -m "hotfix/critical-security-patch: Close session hijacking vulnerability"

# 4. Push and deploy
git push origin hotfix/critical-security-patch
git push origin hotfix/critical-security-patch:main
```

## Performance Tips

- Use the helper script for faster commits
- Set up shell functions/aliases for frequent use
- Cache branch names in pre-commit hooks
- Batch related changes into single commits
