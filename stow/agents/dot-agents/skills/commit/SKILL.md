---
name: commit
description: Stage and commit code following project conventions.
allowed-tools: Bash(git status*), Bash(git diff*), Bash(git add*), Bash(git commit*), Bash(git log*), Bash(pnpm test*), Bash(pnpm run test*)

---

## Context

- *Current git status:* !`git status`
- *Current git diff (staged and unstaged changes):* !`git diff HEAD`
- *Recent commits:* !`git log --oneline -10`

## Your task

### 1. Run tests (ignore for now, tests currently have mem leak)

Before committing, run the test suite:

```bash
pnpm test
```

If any test fails, stop and report the failure. Do not commit broken code.

### 2. Stage files

Stage only the files relevant to this commit. Never use `git add -A` or `git add .` blindly — avoid committing unrelated files, secrets, or large binaries.

### 3. Commit

#### Format

Every commit message must follow this exact format:

```
<type>(<scope>): <description>
```

Where:
- `type` ∈ `{feat, fix, refactor, chore, docs, test, style}`
- `scope` is derived from the top-level folder or module changed — if no clear scope, use `core`
- `description` starts with a lowercase letter
- `description` does not end with a period
- `description` is in English, imperative mood, concise and descriptive
- Max 69 characters on the first line (subject only — body is ignored when validating length)

#### Split rules

Commit in as many commits as needed to keep semantic meaning. Split in this priority order:

1. Different commit types (feat vs fix vs refactor)
2. Tests separated from implementation
3. Different domains, only if unrelated

Do not split tightly coupled changes.

#### Additional rules

- No co-authorship lines in commit messages
- Only consider staged code when writing the message
- Pass the message via heredoc to avoid shell quoting issues:

```bash
git commit -m "$(cat <<'EOF'
type(scope): description
EOF
)"
```
