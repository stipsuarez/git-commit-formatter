# Examples & Patterns

## Real-World Examples

### Feature Development
```
feature/auth: Add two-factor authentication support
feature/dashboard: Implement dark mode toggle
feature/api: Add pagination to user endpoints
```

### Bug Fixes
```
bugfix/api: Handle null response in payment endpoint
bugfix/ui: Fix incorrect font size on mobile
bugfix/auth: Resolve session timeout issues
```

### Release & Version Management
```
release/1.2.0: Bump version and update changelog
release/2.0.0: Major version with breaking changes
hotfix/1.2.1: Security patch for authentication
```

### Maintenance & Refactoring
```
maintenance/deps: Update npm dependencies
maintenance/code: Refactor authentication module
refactor/api: Simplify payment processing logic
docs/api: Add authentication endpoints documentation
```

### CI/CD & Infrastructure
```
ci/github: Add automated testing workflow
ci/deploy: Configure production deployment pipeline
devops/docker: Update base image to latest LTS
```

### Performance & Optimization
```
perf/database: Add index to user queries
perf/bundle: Reduce JavaScript bundle size by 15%
perf/cache: Implement Redis caching layer
```

## Pattern Guide

### Pattern: Feature Development
**When**: Adding new functionality
```
feature/TICKET-ID: Brief description of feature
```
✓ `feature/SCRUM-2343: Implement email notifications`
✗ `feature/SCRUM-2343: Implemented email notifications`

### Pattern: Bug Fixes
**When**: Fixing defects or issues
```
bugfix/ISSUE-ID: Describe the problem solved
```
✓ `bugfix/456: Fix race condition in cache`
✗ `bugfix/456: Race condition fix`

### Pattern: Release Management
**When**: Version bumps and releases
```
release/VERSION: Describe version changes
```
✓ `release/2.1.0: Add new authentication methods`
✗ `release/2.1.0: Minor version bump`

### Pattern: Hotfixes (Critical)
**When**: Urgent production fixes
```
hotfix/CRITICAL-ID: Describe critical fix
```
✓ `hotfix/security: Close SQL injection vulnerability`
✗ `hotfix/security: Fix`

### Pattern: Maintenance Tasks
**When**: Code quality, dependencies, refactoring
```
maintenance/AREA: Describe maintenance work
```
✓ `maintenance/code: Consolidate error handling`
✗ `maintenance/code: Code cleanup`

## Common Mistakes to Avoid

| ❌ Wrong | ✅ Correct | Issue |
|---------|-----------|-------|
| `branch-name Add feature` | `branch-name: Add feature` | Missing colon separator |
| `BRANCH: Added feature` | `BRANCH: Add feature` | Wrong tense |
| `BRANCH: add feature` | `BRANCH: Add feature` | Missing capitalization |
| `Very Long Branch Name That Exceeds Limits: This is a very long message with lots of details` | `BRANCH: Concise description` | Exceeds 72 characters |
| `dev: Added new stuff` | `feature/auth: Add two-factor authentication` | Vague and unclear |
