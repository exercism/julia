# Hints

## General

- Read the Introduction, which steps through a similar example.

## 1. Define a `Fib` type with a constructor that takes `n` as argument

- Keep it simple.
- `n` is how many numbers to generate.

## 2. Implement `iterate` method(s)

- The `state` argument doesn't have to be an integer. It can be of any type.
- Consider which values you need to calculate the next element. A tuple of those should be the `state` argument.
- The `iterate` method returns a tuple with two values `(item, state)`. `item` is the Fibonacci number, i.e. the `item` in `for item in Fib(10)`.
- If your `state` includes several values, consider using a named tuple to clarify the meaning of each value.
  - This is useful but not obligatory.

## 3. Make `collect` work

- One small method.
- If this is missing, read the error messages for clues.

## 4. Enable Julia to infer the type of the elements of the iterator

- One small method.
- After a `collect`, the result should _not_ be `Vector{Any}`.
