# Hints

## 1. Monitor the humidity level of the room

- Simple if...else logic.
- A ternary operator is good enough.
- This task just uses an `error()` function, no `throw()`.

## 2. Detect overheating

- There are two fault conditions to test for.
- Each needs a `throw()` if it fails.

## 3. Monitor the machine

- Mostly, this uses the previous functions.
- Read the Logging section of the introduction to see how to generate log messages.
- The task is simpler than the author intended: it proved hard to test for a mixture of logs and errors reliably. Still thinking about how to extend it!
