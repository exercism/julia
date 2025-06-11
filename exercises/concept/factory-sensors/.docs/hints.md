# Hints

## 1. Check the humidity level of the room

- Simple if...else logic.
- A ternary operator is good enough.
- This task uses an `error()` function, no `throw()`.
- The `@info` macro is also needed.
- Read the Logging section of the introduction to see how to generate log messages.

## 2. Check for overheating

- There are two fault conditions to test for.
- Each needs a `throw()` if it fails.
- The `@info` macro is needed for success.

## 3. Define custom error

- See introduction for an example of defining a custom error.
- Fields and custom print messages are possible but not required.

## 4. Monitor the machine

- You can use the `humiditycheck` and `temperaturecheck` functions, but this is not strictly necessary.
- If you use them, you should be able to check independently if both functions throw errors and add the appropriate logs.
- A variable defined outside of a `try...catch` block can be updated from inside the block if needed.
- Reminder: if one check or both checks fail, you only need to throw one `MachineError` after the logs have been added.
- 
