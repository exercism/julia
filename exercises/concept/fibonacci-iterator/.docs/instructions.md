# Instructions

In this exercise you're going to write an iterator that iterates through the first `n` elements of the [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_number).

**Fibonacci sequence**

The Fibonacci sequence is a sequence of numbers, where every element of the sequence is calculated by adding the two numbers that come before it.
You can think of a sequence as a list of numbers in a certain order.
The first two numbers of the sequence are set to 1.

The start of the sequence is `1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...`

Elements are defined by these rules:

```
a₁ = a₂ = 1
aₙ = aₙ₋₁ + aₙ₋₂
```

For example

- the third element would be `a₃ = a₁ + a₂ = 1 + 1 = 2`
- the fourth would be `a₄ = a₂ + a₃ = 1 + 2 = 3`
- and so on.

~~~~exercism/note
Some sources define the first elements as `a₀ = 0` and `a₁ = 1`.

However in the context of this exercise, we define the sequence without a `0`-th element.
~~~~

## 1. Define the `Fiberator` type

Define the `Fiberator` type with a constructor that takes an integer `n` as the argument.

```julia-repl
julia> Fiberator(10)
Fiberator(10)
```

## 2. Implement `iterate` method(s)

Define both of the necessary `iterate` methods.
The single argument method should take a `Fiberator` type.
The two-argument method should take a `Fiberator` type and a state (with type of your choosing).
Iteration should terminate after the first `n` Fibonacci numbers.

```julia-repl
julia> for a in Fiberator(10)
           println(a)
       end
1
1
2
3
5
8
13
21
34
55
```

**Note**
You can ignore integer overflow in your implementation.
The tests will only use `n` small enough to not cause overflow problems.

## 3. Make `collect` work

Functionality like `collect` and comprehensions require more information than just iteration.
Define the appropriate `length` method to make these work.

```julia-repl
julia> collect(Fiberator(10))
10-element Vector{Any}:
  1
  1
  2
  3
  5
  8
 13
 21
 34
 55
```

## 4. Enable type inference

It is more performant/efficient to help Julia infer the type of the iterator.
Define the appropriate `eltype` method to allow for this.

```julia-repl
julia> collect(Fiberator(10))
10-element Vector{Int64}:
  1
  1
  2
  3
  5
  8
 13
 21
 34
 55
```
