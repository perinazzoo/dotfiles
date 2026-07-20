---
name: commit-push-pr
description: Commit code, push and opens a PR.
allowed-tools: Skill(branch), Skill(commit), Skill(push), Skill(pull-request)
disable-model-invocation: true
argument-hint: '<branch-name>'
---

## Your task

Execute the following steps in order. Stop immediately if any step fails.

1. Invoke `/branch $ARGUMENTS` — validate, create or checkout the branch.
2. Invoke `/commit` — run tests, stage and commit following conventions.
3. Invoke `/push` — validate branch prefix and push to origin.
4. Invoke `/pull-request` — open the GitHub PR targeting main.
