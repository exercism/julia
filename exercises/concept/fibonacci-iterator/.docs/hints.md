# Hints

## General

- Read the Introduction, which steps through a similar example.
- There is another example in the Julia manual section on [Interfaces][iteration-interface].

## 1. Define the `Fiberator` type

- `n` is how many numbers to generate.
- Keep it simple: no other information needed.

## 2. Implement `iterate` method(s)

- See Introduction for important implementation details.
- The `state` argument doesn't have to be an integer. It can be of any type.
- Consider which values you need to calculate the next element. A tuple of those should be the `state` argument.
- The `iterate` method returns a `Tuple` with two values `(item, state)`. `item` is the Fibonacci number, i.e. the `item` in `for item in Fiberator(10)`.
- If your `state` includes several values, consider using a named tuple to clarify the meaning of each value.
  - This is useful for unpacking, but not obligatory.

## 3. Make `collect` work

- One small method (see Introduction for important implementation details).
- If this is missing, read the error messages for clues.

## 4. Enable type inference

- One small method (see Introduction for important implementation details).
- Be careful with the argument for the method.
- After a `collect`, the result should _not_ be `Vector{Any}`.

[iteration-interface]: https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-iteration
