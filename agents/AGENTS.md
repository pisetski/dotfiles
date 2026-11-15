# Global Rules

## Requests

- Ask before acting only when an ambiguity would change the result and the code or context can't resolve it; otherwise state the assumption and proceed.

## Code

- Comments are a smell: express intent through names, and comment only edge cases code can't convey.
- No abstractions for a single caller and no configurability without a current need.

## Changes

- Keep the diff to the request: no drive-by reformatting, renaming, or reorganizing; mention unrelated problems instead of fixing them.
- Commit with a subject line only, never a body.

## Debugging

- Reproduce first, then fix the root cause rather than the symptom.
- Check one hypothesis at a time with the smallest probe or change.
- After two failed fixes, stop and recheck your assumptions instead of trying a third.

## Testing

Applies to code with a test suite; skip for config, docs, and throwaway spikes.

- Red: write the test first (for a bug, one that reproduces it) and watch it fail for the expected reason.
- Green: write the minimal code that makes it pass.
- Mutate: break the code under new tests (flip a condition, drop a line); if nothing fails, strengthen the test, then revert. Prefer the project's mutation tool if it has one.
- Test behavior through public interfaces; assert on outputs and observable effects, not internal calls or private state.
- Mock only at system boundaries (network, filesystem, clock).
- Fix the code, not the test: never weaken, skip, or delete a failing test to get green; change it only when intended behavior changed or it was coupled to implementation, and say which.
