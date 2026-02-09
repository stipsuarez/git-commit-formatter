# Troubleshooting

## Common Issues & Solutions

### Issue: Branch Name Contains Special Characters

**Problem:** Branch names with special characters break commit format.

**Examples of problematic branches:**
- `feature/auth@v2` - @ symbol
- `bugfix/issue#456` - # symbol
- `release/v1.2.3-rc1` - Multiple special characters

**Solution:**
Use hyphens or forward slashes instead of special characters:
```bash
# ✗ Avoid
git checkout -b feature/auth@v2

# ✓ Use
git checkout -b feature/auth-v2
```

**Result:**
```
feature/auth-v2: Add authentication version 2
```

### Issue: Commit Message Exceeds 72 Characters

**Problem:** Message is too long for terminal display.

**Symptom:** Helper script warns or truncates message.

**Solution 1: Abbreviate key terms**
```
# ✗ Too long (89 characters)
maintenance/code: Refactor authentication module to improve code quality and maintainability

# ✓ Better (68 characters)
maintenance/code: Refactor authentication module for better maintainability
```

**Solution 2: Focus on what, not why**
```
# ✗ Too long (87 characters)
feature/api: Add API endpoint that returns user data because the frontend needs it

# ✓ Better (58 characters)
feature/api: Add user profile endpoint
```

**Solution 3: Split into multiple commits**
```bash
# Instead of one large commit, split concerns:
git commit -m "feature/api: Add user profile endpoint"
git commit -m "docs/api: Document user profile endpoint"
git commit -m "test/api: Add user profile endpoint tests"
```

### Issue: Wrong Branch Name in Commit

**Problem:** Committed on wrong branch, commit shows incorrect branch name.

**Symptoms:**
- Commit message shows `feature/auth` but you're on `bugfix/api`
- Mixed commits from different branches in history

**Solution 1: Amend the last commit (if not pushed)**
```bash
# Switch to correct branch
git checkout feature/auth

# Move your latest commit there
git cherry-pick COMMIT_HASH

# Remove from wrong branch
git checkout bugfix/api
git reset --hard HEAD~1
```

**Solution 2: Rebase on correct branch**
```bash
# Current branch has 3 commits that should be on feature/auth
git rebase --onto feature/auth bugfix/api

# Or interactively rebase to fix commit messages
git rebase -i HEAD~3
# Change the commits to use correct branch name
```

**Solution 3: Create new commit (if already pushed)**
```bash
# Create commit with correct branch name on correct branch
git checkout feature/auth
git cherry-pick OLD_COMMIT_HASH
git commit --amend -m "feature/auth: Correct description"

# Remove old commit from wrong branch (if safe)
git checkout bugfix/api
git revert OLD_COMMIT_HASH
```

### Issue: Forget Branch Name in Commit Message

**Problem:** Forgot to include branch name in commit.

**Example:** Committed `"Fix login bug"` instead of `"SCRUM-2343: Fix login bug"`

**Solution 1: Amend last commit (if not pushed)**
```bash
# Get current branch
$branch = git branch --show-current

# Amend with correct format
git commit --amend -m "$branch`: Fix login bug"
```

**Solution 2: Create fixing commit (if already pushed)**
```bash
$branch = git branch --show-current
git commit -m "$branch`: Fix commit message from previous commit"

# Or rebase to fix
git rebase -i HEAD~1
# Mark first commit as 'reword' and update the message
```

### Issue: Commit Message in Wrong Tense

**Problem:** Used past tense instead of imperative mood.

**Examples of wrong tense:**
```
# ✗ Wrong
SCRUM-2343: Added authentication
bugfix/api: Fixed null pointer
feature/ui: Implemented dark mode
```

**Solution: Amend the commit**
```bash
git commit --amend -m "SCRUM-2343: Add authentication"
git commit --amend -m "bugfix/api: Fix null pointer"
git commit --amend -m "feature/ui: Implement dark mode"
```

### Issue: Helper Script Not Working

**Problem:** PowerShell script throws error or doesn't execute.

**Common errors:**
- `cannot be loaded because running scripts is disabled`
- `file not found`
- `permission denied`

**Solution 1: Enable script execution**
```powershell
# Allow scripts for current user
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Or run with explicit permission
powershell -ExecutionPolicy Bypass -File .\scripts\git-commit-format.ps1 "Your message"
```

**Solution 2: Check script location**
```powershell
# Verify script exists
Test-Path .\scripts\git-commit-format.ps1

# Run with full path
& "C:\Users\Cheil\.agents\skills\git-commit-formatter\scripts\git-commit-format.ps1" "Your message"
```

**Solution 3: Use manual command instead**
```bash
$branch = git branch --show-current
git commit -m "$branch`: Your message"
```

### Issue: CI/CD Validation Failures

**Problem:** Automated checks reject commit messages.

**Symptoms:**
- Pipeline fails on commit validation step
- Pull request blocked by commit message checks
- Build status shows "Checks failed"

**Solution 1: Review validation rules**
Check your repository's validation configuration:
```bash
# Check pre-commit hooks
cat .git/hooks/pre-commit

# Check CI/CD workflow
cat .github/workflows/*.yml

# Check project documentation
cat CONTRIBUTING.md
```

**Solution 2: Fix and recommit**
```bash
# Fix to match team standards
git commit --amend -m "BRANCH: Correct message format"

# Force push to update PR (use with caution)
git push --force-with-lease origin BRANCH
```

**Solution 3: Request exception**
If validation rules are too strict:
1. Document why in PR description
2. Request approval from team lead
3. Ask for rule adjustment in team discussion

### Issue: Inconsistent Commit History

**Problem:** Mixed commit formats in project history (some with branch, some without).

**Why it happens:**
- New team members not following standards
- Different teams with different conventions
- Gradual adoption of formatting rules

**Solution 1: Educate team**
- Share this skill with all developers
- Add to onboarding documentation
- Reference in pull request reviews

**Solution 2: Automate enforcement**
```bash
# Add pre-commit hook
cp scripts/pre-commit-hook.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Enable GitHub branch protection with validation
```

**Solution 3: Bulk rewrite history (use carefully!)**
```bash
# Interactively rebase last 20 commits
git rebase -i HEAD~20

# Update messages to follow convention
# Only do this if commits haven't been shared yet
```

## Debug Mode

Enable verbose output for troubleshooting:

```powershell
# Run script in debug mode
$DebugPreference = 'Continue'
& .\scripts\git-commit-format.ps1 "Your message"

# Check git configuration
git config --list | grep -i commit

# View recent commits with full details
git log --oneline -15
git log -p -3  # Show last 3 commits with diffs
```

## Need More Help?

1. **Check branch name:** `git branch --show-current`
2. **Review recent commits:** `git log --oneline -10`
3. **Test format:** `"$(git branch --show-current): Your description"`
4. **Report issues:** https://github.com/stipsuarez/git-commit-formatter/issues
