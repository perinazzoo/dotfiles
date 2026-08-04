@RTK.md

## Testing preferences

- Prefer behavior tests (real inputs/outputs, observable effects) over implementation/interaction tests (asserting a mocked collaborator was called with specific args, e.g. `toHaveBeenCalledWith`). If mocking a collaborator is unavoidable, make sure that collaborator's own logic has real behavior-level coverage somewhere, and call it out if it doesn't.
