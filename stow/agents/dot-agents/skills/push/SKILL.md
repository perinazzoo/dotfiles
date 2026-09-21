---
name: push
description: Push current branch to origin with prefix validation.
allowed-tools: Bash(git branch --show-current), Bash(git push*)

---

## Context

- *Current branch:* !`git branch --show-current`

## Your task

### 1. Validate branch prefix

The current branch must start with one of the allowed prefixes:

- `feat/`
- `fix/`
- `refactor/`
- `refac/`
- `hotfix/`

If it does not → abort execution immediately. Do not push.

### 2. Push

```bash
git push -u origin <branch-name>
```
