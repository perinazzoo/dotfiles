## Code comments

- Comment only where a comment earns its place. Prefer code that does not need one: a clearer name, a smaller function, an earlier return.
- Doc comments (JSDoc and equivalents) on exported or public API are welcome — describe what the caller needs to know: contract, parameters, return, and any surprising behavior.
- Explain **why**, never **what**. A comment restating the line below it is noise.
- Never write a comment that narrates an edit — that a value changed, that something used to be different, that this once caused a bug, or that a workaround was added on some date. That history belongs in the commit message and the diff, which is where someone will look for it. The code should read as if it had always been written this way.
- A worthwhile comment is one a reader could not recover from the code itself: a non-obvious constraint, an external quirk being worked around, a deliberate trade-off, or a reference to a spec or issue.

## Git commits

- **Always write commit messages in English** — subject line and body — even when the conversation, the codebase, or the project's own strings (error messages, docs, comments) are in another language. A project instruction that mandates another language for user-facing strings does not extend to commit messages.

## Testing preferences

- Prefer behavior tests (real inputs/outputs, observable effects) over implementation/interaction tests (asserting a mocked collaborator was called with specific args, e.g. `toHaveBeenCalledWith`). If mocking a collaborator is unavoidable, make sure that collaborator's own logic has real behavior-level coverage somewhere, and call it out if it doesn't.
