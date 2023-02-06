# About

In Julia, like many other languages, allow for the following with `if`-expressions:

- Chained if-expressions
- Nested if-expressions

~~~~exercism/note
[`if`-expressions](https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation) as defined here will encompass the following syntaxes:`if`, `if-else` and `if-elseif-else` statements.
~~~~

`if`-expressions allows for branching in our programs, given a condition is satisfied.

## A prompt program example

Suppose you've defined a `password_checker(password)` function that returns `true`, if the password entered by the user is correct.

```julia
# Login prompt
println("Enter Password: ")

# Get user input
password = readline()

# Our main logic
if password_checker(password)
    println("Welcome!")
end
```
Although the above program is not very realistic, but it shows the anatomy of an `if` statement. 

In this case the `println("Welcome!")` is run, if the `password_checker(password)` returns `true`, otherwise it is skipped.

We can do the following for effective branching:

## Chained expressions example

```julia
# We can test for multiple cases
# with chained if expression.
if 0 ≤ n ≤ 0.5
    println("n is in the interval [0, 0.5], inclusive.")
elseif -0.5 ≤ n < 0
    println("n is in the interval [-0.5, 0).")
elseif n > 0.5
    println("n is greater than 0.5.")
else
    println("n is less than -0.5.")
end
```

In the above chained expression, we can have mulitple `elseif` statements, with only one `else` statement at the end, but it's not necessary. 

## Nested expressions example

```julia
# We can refine our coniditonal evaluation
# with nested if expressions.
if n ≥ 0
    if 0.5 ≤ n ≤ 1
        println("n is in the interval [0.5, 1], inclusive.")
    else
        println("n is in the interval [0, 0.5).")
    end
else
    println("n is negative!")
end
```

## Order matters

```julia
# Suppose you guessed the number 2,
# then the if block will be executed,
# and the others skipped.
if guess_number > 0
    println("The number guessed is greater than 0.")
elseif guess_number > 1
    println("The number guessed is greater than 1.")
else
    println("n is negative!")
end
```
In the above `if` expression, it is instructive to note that even though the conditional expression in the `elseif` clause would evaluate to `true`, it is skipped,
since the conditional in the `if` clause is `true` first.

As such sometimes you'll get unexpected results depending on how you structure your `if` expression.