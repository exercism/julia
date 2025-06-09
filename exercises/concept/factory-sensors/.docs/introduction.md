# Introduction

Programmers generally try to write perfect software, and generally fail.

Things go wrong, unexpectedly, and we need to be able to deal with that.

Some language designers believe that the priority is to detect an error as quickly as possible, then terminate execution with an informative message to aid debugging.

Data science languages tend to take a more nuanced approach.
Some errors are so serious that immediate termination is necessary, but often it is better to flag a problem as something to be dealt with later, then continue execution.

We saw in the [Nothingness][nothingness] Concept that Julia provides various placeholders for problematic values: `nothing`, `NaN` and `Inf`.
Whether these are a better approach than program termination in a particular situation is a matter for programmer judgement.

_A point of nomenclature_ before getting into the details: the Julia documentation treats the words "error" and "exception" as largely interchangeable.
The content below may be equally inconsistent.

## Standard error types

By this point in the syllabus, you must have seen many error messages from Julia.
For example:

```julia-repl
julia> Int(3.14)
ERROR: InexactError: Int64(3.14)
```

Trying to cast a float to an integer involves a loss of precision, so we get an `InexactError`.

`InexactError` is a type, one of several ([currently 25][errors]) built into Julia as standard.
All are subtypes of `Exception`:

```julia-repl
julia> supertype(InexactError)
Exception
```

## `throw()`

Some of the standard error types might be useful to generate in your own code.

Like all concrete types, the errors have constuctors.
They take a variety of arguments, so check the [documentation][errors] for the one you want to use.

```julia-repl
julia> DomainError(42, "out of range")
DomainError(42, "out of range")
```

To use the error, wrap the constructor in a `throw()` function:

```julia-repl
julia> throw(DomainError(42, "out of range"))
ERROR: DomainError with 42:
out of range
```

## `error()`

For a quick-and-dirty approach, the `error()` function can be convenient.
It takes a string (or the components of a string) as argument:

```julia-repl
julia> happy = false;
julia> happy || error("😞 something went wrong")
ERROR: 😞 something went wrong
```

## Custom errors

Creating new error types is in principle very easy.
Just add another subtype of `Exception`:

```julia-repl
julia> struct MyError <: Exception end

julia> throw(MyError)
ERROR: MyError
```

## Assertions

The basic idea of an assertion is "this statement ought to be true, so complain loudly if it is false."
The value of this is mainly during debugging, as production code should never fail an assertion.

We saw in the [Types][types] Concept that we can add type assertions, for example to check the return type of a function.

```julia-repl
julia> 42::Number
42

julia> "two"::Number
ERROR: TypeError: in typeassert, expected Number, got a value of type String
```

More generally, the `@assert` macro lets us test any expression that evaluates to a boolean:

```julia-repl
julia> n = 22;
julia> @assert isodd(n) "n must be odd"
ERROR: AssertionError: n must be odd
```

## `try`...`catch`

Some errors are necessarily fatal, but often we expect the program to recover gracefully.

By default, an error immediately terminates the current function, and the error (with any informative message) is passed to the calling function.

This continues up the call stack, until the top-level code terminates with an error message.

At any stage, the error can be intercepted with a `try...catch` block which attempts to handle it.

```julia-repl
julia> n = -1;
julia> try
           log_n = log(n)
       catch problem
           if problem isa DomainError # number out of range
               @warn "you may have supplied a negative real number: $n"
               @info "trying with complex argument"
               log_n = log(Complex(n))  # fallback calculation

           elseif problem isa MethodError # no idea what n is
               @error "please supply a valid argument"
 
           else
              rethrow() # the error could be anything else
           end
      end
┌ Warning: you may have supplied a negative real number: -1
└ @ Main REPL[3]:5
[ Info: trying with complex argument
0.0 + 3.141592653589793im  # success
```

In the example above, `log(n)` needs `n` to be either a positive real value, or any complex value.
The `try ... catch` traps problems with negative real values, returning the correct complex answer `iπ` in mathematical notation.

If you supply, for example, a string argument, there is no recovery except asking the user to correct it.

As a final catch-all, we added `rethrow()` for anything which is neither `DomainError` nor `MethodError`.

***Note:*** Sometimes a `try...catch` is what you need, but please avoid over-using it.
If an `if...else` block can be used instead, it will be much more performant than catching exceptions.

## Logging

Note that the `error()` function, discussed above, should not be confused with the `@error` macro.

The function generates an exception, which will be passed up the call stack unless caught.

The `@error` macro, along with its `@debug`, `@info` and `@warn` counterparts, is part of the `Logging` module, and intended to generate informative messages without altering program flow.

Output goes to the terminal by default (color-coded by severity), though in a real application there are many other possibilities.

```julia-repl
julia> @warn "Something looks not quite right"
┌ Warning: Something looks not quite right
└ @ Main REPL[55]:1

julia> @error "Panic!"
┌ Error: Panic!
└ @ Main REPL[56]:1
```

See also the previous example, under `try...catch`.


[nothingness]: https://exercism.org/tracks/julia/concepts/nothingness
[errors]: https://docs.julialang.org/en/v1/manual/control-flow/#Built-in-Exceptions
[types]: https://exercism.org/tracks/julia/concepts/types
