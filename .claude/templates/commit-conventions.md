# Git Commit Message Conventions

## Format
```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools and libraries

## Scope
Optional, indicates the area of the codebase affected:
- **api**: API related changes
- **ui**: User interface changes
- **auth**: Authentication related
- **db**: Database related
- **config**: Configuration changes

## Description
- Use imperative mood ("add" not "added")
- Keep under 50 characters
- Don't capitalize first letter
- Don't end with a period

## Examples
```
feat(auth): add OAuth2 login integration
fix(api): resolve memory leak in user service
docs: update installation instructions
style: format code with prettier
refactor(ui): extract reusable button component
perf(db): optimize user query with indexing
test(auth): add unit tests for login flow
chore: update dependencies to latest versions
```

## Breaking Changes
Add `BREAKING CHANGE:` in the footer for breaking changes:
```
feat(api): remove deprecated endpoints

BREAKING CHANGE: The /v1/users endpoint has been removed. Use /v2/users instead.
```