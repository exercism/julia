# About

In Julia, **integers** and **floating-point** numbers, also called float(s), are primitive[^1] numeric types and forms the basis of arithmetic computation.

[^1]: Primitive numeric types are called such since number types such as **Complex** and **Rational** numbers are built upon them.

## Integer types

```julia
# Integers are the positive, and
# negative whole numbers including zero.
julia> 99
99

julia> -1234
-1234

julia> 0
0

# We can check the type of a number.
julia> typeof(3)
Int64
```

In the latter line, we can check the type of numeric type with the `typeof` function.

## Floating-point types

```julia
# Floating-point numbers are decimal representations of a number.
julia> 5.3
5.3

julia> -3.0
-3.0

# Floating-point version of the integer 0.
julia> 0.0
0.0

julia> typeof(0.5)
Float64
```

## Arithmetic

Julia has full support for arithmetic operations on integers, floating-point, complex and rational numbers and they are executed according to the [operator precedence](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity).

In Julia, if one of the operands is a float, the remaining integers will be converted to floats and then the arithmetic operation executed.

### Addition and Subtraction

```julia
julia> 3 + 6
9

# The integer is converted to a float,
# then the described operation is executed,
# returning the value in float.
julia> 1.0 - 2
-1.0
```

### Multiplication

```julia
julia> 6 * 3
18

julia> 1.0 * 7
7.0
```

### Division

#### True Division

```julia
# Notice that the operands are both integers,
# however, Julia returns a float.
julia> 8 / 4
2.0

julia> 9 / 2.5
3.6
```

#### Integer Division

```julia
# Performs division between the two operands,
# truncates the decimal part, returns integer part.
julia> 9 ÷ 2
4

# Equivalent to the above code.
julia> ÷(9, 2)
4
```

#### Interesting behaviour of True Division vs. Integer Division

```julia
# Inf in Julia represents positive infinity.
# True division doesn't produce an error in Julia.
julia> 1/0
Inf

# Integer division produces an error in Julia.
julia> div(1, 0)
ERROR: DivideError: integer division error
```

#### Inverse Division

```julia
# Equivalent to 15 / 3
julia> 3 \ 15
5.0
```

### Exponentiation

```julia
# The integer 8 (base) raised to the power of 2 (exponent).
julia> 8 ^ 2
64

julia> 10 ^ 3.0
1000.0

# Any float between 0 and 1 raised to an infinitely large positive number,
# returns 0.0
julia> 0.5 ^ Inf
0.0
```

### Modulo

```julia
# Returns the remainder 1 after performing division on the two operands.
julia> 5 % 2
1

# Equivalent to the above code.
julia> rem(5, 2)
1
```

**Test yourself**:

What does the below expressions return in Julia?

- `5 % 0`
- `rem(100, 0)`

### Order of Operations

In Julia, mathematical expression involving the above mentioned arithmetic operations follow the [order of operations](https://en.wikipedia.org/wiki/Order_of_operations) rules, also known as [PEMDAS](https://en.wikipedia.org/wiki/Order_of_operations#Mnemonics).

```julia
# ^ has highest priority,
# then division,
# followed by substraction and addition, from left to right.
julia> 5 - 2 + 10 / 2 ^ 2
5.5

# Equivalent to the above,
# but with the use of parentheses.
julia> (5 - 2) + (10 / 2 ^ 2)
5.5
```

**Test yourself**:

- What does the mathematical expression `3 * 10 - 5 + 7 % 2` return in Julia?
- Can you insert parentheses in the above expression to produce the same result?

## Numeric Formulae

Julia has many intuitive features in order to represent mathematical formulas, such as: $2x^2 + 3x$.

```julia
# Assume that x has a value of 5
julia> x = 5
5

# Julia permits the variable x
# to be preceded by a number.
# Equivalent to 3 * x
julia> 3x
15

# Altogether
julia> 2x^2 + 3x
65

# Julia permits this.
julia> (x + 1)x
30

# Julia prohibits this.
julia> x(x + 1)
ERROR: MethodError: objects of type Int64 are not callable
```

More can be read on what Julia allows on [numeric literal coefficients](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#man-numeric-literal-coefficients).
