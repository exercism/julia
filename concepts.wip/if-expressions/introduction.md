# Introduction

In Julia, `if`-expressions, are similar to those seen in other languages.

~~~~exercism/note
`if`-expressions as defined here will encompass the following syntaxes:`if`, `if-else` and `if-elseif-else` statements.
~~~~

`if`-expressions provide the ability to execute certain statements in a _code block_ given that the conditional is satisfied. In other words, it allows for branching in our programs.

## `If` statement example

```julia
# Defining a function, allows to pass different values
# to test. The if statement is the code block inside
# the function.
julia> function say_positive(n)
           if n > 0
               println("n is positive!")
           end
       end
say_positive (generic function with 1 method)

# 10 > 0 which enters the if block
# and executes the println("n is positive!") 
# statement.
julia> say_positive(10)
n is positive!

# -10 < 0, if expression is skipped
# and no print to screen.
julia> say_positive(-10)
```
`n > 0` following immediately the `if` keyword above is the conditional expression (a boolean expression), must always return `true` or `false` for the `if`-expression to be executed.


~~~~exercism/note
In Julia, the `end` keyword signifies the end of all block expressions.
This syntax is not specific to `if`-expressions or function definitions.
~~~~

## `if`-`else` syntax example

```julia
julia> function say_if_positive(n)
           if n > 0
               println("n is positive!")
            else
               println("n is negative!")
           end
       end

say_if_positive (generic function with 1 method)

# Again, -10 < 0, the if block is skipped,
# else block is executed, as the only other 
# alternative.
julia> say_if_positive(-10)
n is negative!
```
## `if`-`elseif`-`else` syntax example

```julia
julia> function say_if_positive_or_zero(n)
           if n > 0
               println("n is positive!")
            elseif n < 0
               println("n is negative!")
            else
               println("n is zero!")
           end
       end

say_if_positive_or_zero (generic function with 1 method)

# We explicitly test for n to be negative number
# in the elseif block.
julia> say_if_positive_or_zero(-3)
n is negative!

# 0 is neither positive nor negative,
# else block is executed.
julia> say_if_positive_or_zero(0)
n is zero!
```

