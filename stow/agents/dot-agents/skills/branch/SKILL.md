---
name: branch
description: Validate, create, or checkout a branch following naming conventions.
allowed-tools: Bash(git branch*), Bash(git checkout*)
argument-hint: '<branch-name>'
---

## Your task

### 1. Validate argument

- `$ARGUMENTS` must represent a branch name.
- If empty → abort execution.
- If it does not start with one of the allowed prefixes → abort execution.

Allowed prefixes:
- `feat/`
- `fix/`
- `refactor/`
- `refac/`
- `hotfix/`

Do not auto-prefix. Do not auto-correct. Use `$ARGUMENTS` exactly as provided.

### 2. Ensure branch

- If branch exists locally → checkout.
- Else → create and checkout.
