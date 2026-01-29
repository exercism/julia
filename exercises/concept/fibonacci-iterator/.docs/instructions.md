# Instructions

In this exercise you're going to write an iterator that iterates through the first `n` elements of the [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_number).

## Fibonacci sequence

The Fibonacci sequence is a sequence of numbers, where every element of the sequence is calculated by adding the two numbers that come before it.
You can think of a sequence as a list of numbers in a certain order.
The first two numbers of the sequence are set to 1.

The start of the sequence is `1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...`

Elements are defined by these rules:

```
a[1] = a[2] = 1
a[n] = a[n-1] + a[n-2]
```

For example

- the third element would be `a[3] = a[1] + a[2] = 1 + 1 = 2`
- the fourth would be `a[4] = a[2] + a[3] = 1 + 2 = 3`
- and so on.

~~~~exercism/note
Some sources define the first elements as `a[0] = 0` and `a[1] = 1`.

However in the context of this exercise, we define the sequence without a `0`-th element.
~~~~

## 1. Define a `Fib` type with a constructor that takes `n` as argument

```julia-repl
julia> Fib(10)
Fib(10)
```

## 2. Implement `iterate` method(s)

```julia-repl
julia> for a in Fib(10)
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

You can ignore integer overflow in your implementation.
The tests will only use `n` small enough to not cause overflow problems.

## 3. Make `collect` work

```julia-repl
julia> collect(Fib(10))
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

## 4. Enable Julia to infer the type of the elements of the iterator

```julia-repl
julia> collect(Fib(10))
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
