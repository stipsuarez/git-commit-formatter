# Git Commit Formatter Script
# This script creates properly formatted git commits following: BRANCH_NAME: description

param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string]$CommitMessage
)

# Get the current branch name
try {
    $branch = git branch --show-current 2>$null
    if (-not $branch) {
        Write-Error "Not in a git repository or unable to determine current branch"
        exit 1
    }
} catch {
    Write-Error "Error getting current branch: $_"
    exit 1
}

# Validate commit message
if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
    Write-Error "Commit message cannot be empty"
    Write-Host "Usage: git-commit-format 'Your commit message here'"
    exit 1
}

# Build the formatted commit message
$formattedMessage = "$branch`: $CommitMessage"

# Check message length
if ($formattedMessage.Length -gt 72) {
    Write-Warning "Commit message exceeds 72 characters (current: $($formattedMessage.Length))"
    Write-Host "Message: $formattedMessage"
    Write-Host "`nConsider keeping it shorter for better readability."
}

# Display formatted message
Write-Host "Creating commit:"
Write-Host "  Branch: $branch"
Write-Host "  Message: $formattedMessage"
Write-Host ""

# Create the commit
try {
    git commit -m $formattedMessage
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Commit created successfully!" -ForegroundColor Green
    } else {
        Write-Error "Git commit failed"
        exit 1
    }
} catch {
    Write-Error "Error creating commit: $_"
    exit 1
}
