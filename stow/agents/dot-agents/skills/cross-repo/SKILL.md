---
name: cross-repo
description: Delegate changes in other repositories to Paseo agents running in fresh workspaces. Use whenever a task requires editing a repository other than the current workspace's (e.g. frontends consuming an API change), even if the user does not mention Paseo.
user-invocable: true
argument-hint: '[repo ...] [task]'
---

# Cross-repo Skill

The current agent owns only its workspace's repository. Every other repository gets its own Paseo agent in a fresh workspace. You MUST NOT edit, commit, or run write commands in another repository directly. Reading it to understand the contract is fine.

## Prerequisites

Read the **paseo** skill before calling any Paseo tool.

## 1. Resolve target repositories

- Use the repos named in `$ARGUMENTS` or in the conversation.
- Find each repo's path: check `paseo project ls`, `list_workspaces`, then sibling directories of the current repo.
- If a repo is ambiguous or not found, ask the user. Do not guess.
- Skip the current repo. It stays yours.

## 2. Define the contract first

Before delegating, settle what the other repos depend on: endpoints, request/response shapes, types, enums, env vars, feature flags, error codes. The current repo is the source of truth. If the contract is still moving, finish it before launching agents, or tell the user the delegation is premature.

## 3. Create one workspace per target repo

For each target repo:

1. `git -C <path> fetch origin`.
2. Resolve the default branch: `git -C <path> symbolic-ref --short refs/remotes/origin/HEAD`.
3. Call `create_workspace` with `isolation: "worktree"`, `mode: "branch-off"`, `path: <repo path>`, `baseBranch: <origin default branch>`, and `branchName` equal to the current repo's branch when it follows the allowed prefixes (`feat/`, `fix/`, `refactor/`, `refac/`, `hotfix/`). Otherwise derive a short prefixed name from the task.

Never reuse a workspace that already has unrelated work.

## 4. Launch agents

Call `list_profiles` and pick the profile whose `notes` best match the work, as described by the **paseo** skill.

Call `create_agent` per workspace, all in parallel when independent, with title `[<repo>] <task>` and `workspaceId` set. Write the initial prompt following the handoff prompt format and rules of the **paseo-handoff** skill. On top of that format, the prompt MUST include:

- `## Origin` — repo and branch where the source change lives, and why this repo must change.
- `## Contract` — exact endpoints, payloads, types, enums, error codes. Paste shapes verbatim.
- In `## Constraints`:
  - Work only in this repository.
  - Do not commit or push unless explicitly told to.
  - If the contract seems wrong or insufficient, stop and report instead of improvising.

## 5. Follow through

- Keep working on the current repo. Do not poll; completion notifications arrive on their own.
- When an agent finishes, check its result with `get_agent_activity` and report a short summary to the user per repo.
- If the contract changes later, send the delta to every affected agent with `send_agent_prompt`.
- Do not archive workspaces unless the user asks.
