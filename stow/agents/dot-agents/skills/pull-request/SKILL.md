---
name: pull-request
description: Open a GitHub pull request for the current branch.
allowed-tools: Bash(gh pr create*), Bash(gh pr view*)

---

## Context

- *Current branch:* !`git branch --show-current`
- *Recent commits:* !`git log --oneline -10`

## Your task

### 1. Validate

- Never open a PR from `main` or `master` → abort if so.
- Never open a PR with failing tests — they must have passed in the commit step.

### 2. Open the PR

```bash
gh pr create \
  --title "<title>" \
  --body "$(cat <<'EOF'
<body>
EOF
)"
```

Always pass the body via heredoc — inline `--body` is not shell-safe with newlines.

#### Title

Same format as commits — imperative, max 69 characters:

```
<type>(<scope>): <short description>
```

#### Body

```markdown
## What

<One or two sentences describing what this PR does.>

## Why

<Why this change is needed — context, motivation, or linked milestone.>

## How

<Brief description of the approach taken, if non-obvious.>
```

When a GitHub issue is associated with the task, always append to the body:

```markdown
Closes #<issue-number>
```

Use `Closes` — not `Fixes` or `Resolves`.

- PR target must always be `main`.
- Never mention agents in the PR description.

### 3. Verify

After creating the PR, confirm it was opened correctly:

```bash
gh pr view
```

Check that:
- URL was generated and is accessible
- Title and body match what was submitted
- Target branch is `main`
