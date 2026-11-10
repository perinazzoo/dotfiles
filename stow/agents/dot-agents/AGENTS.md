> **The key words MUST, MUST NOT, SHOULD, SHOULD NOT, and MAY in this file are to be interpreted as described in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119).**

## Directives

Short sentences. Commit subject MUST be imperative mood (`add`, not `added`/`adds`); body only for a fact the diff cannot show. Comments only where code needs clarification — never narration.

## Code comments

- Doc comments (JSDoc and equivalents) on exported or public API are welcome — describe what the caller needs to know: contract, parameters, return, and any surprising behavior.
- Explain **why**, never **what**.

## Git commits

- **Always write commit messages in English** — subject line and body — even when the conversation, the codebase, or the project's own strings (error messages, docs, comments) are in another language. A project instruction that mandates another language for user-facing strings does not extend to commit messages.
- Commit messages must not be co-authored by agents.
- Keep messages concise but descriptive; the subject line must not exceed 72 characters (count only the first line, ignore the body when checking length).
- Follow Conventional Commits format for the subject: `<type>(<scope>): <description>`, where:
  - `type` ∈ {feat, fix, refactor, chore, docs, test, style}
  - `scope` is derived from the top-level folder or module changed; use `core` if no clear scope exists
  - `description` starts with a lowercase letter and does not end with a period
- When a change needs more than one commit, split them in this priority order:
  1. Different commit types (feat vs fix vs refactor)
  2. Tests separated from implementation
  3. Different domains, only if unrelated
  - Do not split tightly coupled changes.

## Testing preferences

- Prefer behavior tests (real inputs/outputs, observable effects) over implementation/interaction tests (asserting a mocked collaborator was called with specific args, e.g. `toHaveBeenCalledWith`). If mocking a collaborator is unavoidable, make sure that collaborator's own logic has real behavior-level coverage somewhere, and call it out if it doesn't.

## Multi-repo work

- An agent owns only its workspace's repository.
- When a task requires changes in another repository, you MUST NOT edit it directly. You MUST delegate through the `cross-repo` skill, which creates a fresh Paseo workspace and agent per repository — even if the user does not mention Paseo.
- Reading other repositories to understand a contract is allowed.

## Language

User-facing text MUST be in Brazilian Portuguese (pt-BR).

## RTK

@~/.claude/RTK.md
