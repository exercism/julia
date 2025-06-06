# Hints

This exercise is centered around a keyword composite type with type unions.

## 1. Define type unions

- See the example where a type was named.

## 2. Implement the Player composite type

- All fields should be *annotated with types* (see `Node` example in introduction), two of which with type unions
- All fields should have the default values in the instructions

## 3. Introduce yourself

- A [ternary operator][control-flow] can be used for a one line solution.
- The `ismissing` function is useful here.

## 4. Implement increment methods

- The arguments of the methods need to be annotated with the correct types.
- See example of argument annotation in the introduction.
- [Ternary operators][control-flow] can also be used here for a one line solution.

## 5. Implement the title function

- Use your `increment` function.
- A [ternary operator][control-flow] can be used for a one line solution.

## 6. Implement the revive function

- You can use your `increment` function here.
- Return a modified player if they were dead, or an unmodified player if they were alive.

## 7. Implement the spell casting function

- When doing checks on type unions with `Nothing`, it's often best to start with the function `isnothing`.
- When the type is found to be something, mathematical checks can be done.
- Don't forget to modify the fields in the player.
- Return the damage of the spell in all cases.

[control-flow]: https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation
