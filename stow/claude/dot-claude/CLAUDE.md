@RTK.md

## Git commits

- **Always write commit messages in English** — subject line and body — even when the conversation, the codebase, or the project's own strings (error messages, docs, comments) are in another language. A project instruction that mandates another language for user-facing strings does not extend to commit messages.

## Testing preferences

- Prefer behavior tests (real inputs/outputs, observable effects) over implementation/interaction tests (asserting a mocked collaborator was called with specific args, e.g. `toHaveBeenCalledWith`). If mocking a collaborator is unavoidable, make sure that collaborator's own logic has real behavior-level coverage somewhere, and call it out if it doesn't.
