# About

## Comparison operators

[Comparison operators in Julia][numeric-comparisons] are similar to many other languages, though with some extra options for math-lovers.

For equality, the operators are `==` (equal) and `!=` or `≠` (not equal).

```julia
txt = "abc"
txt == "abc"  # true
txt != "abc"  # false
txt ≠ "abc"  # false (synonym for !=)
```

In addition, we have the various greater/less than operators.

```julia
1 < 3  # true
3 > 3  # false
3 <= 3  # true
3 ≤ 3  # true (synonym for <=)
4 >= 3  # true
4 ≥ 3  # true (synonym for >=)
```

As often with Julia, an appropriate editor makes use of the mathematical symbol easy.
Type `\ne`, `\le` or `\ge` then `TAB` to get `≠`, `≤` or `≥`.

The previous example uses only numbers, but we will see in other parts of the syllabus that various additional types have a sense of ordering and can be tested for greater/less than.

Comparison operators can be chained, which allows a clear and concise syntax:

```julia
n = 3
1 ≤ n ≤ 5  # true (n "between" two limits)
```

The previous example is a synonym for `1 ≤ n && n ≤ 5`.

## Branching with `if`

This is the full form of an [`if` statement][conditional-eval]:

```julia
if conditional1
    statements...
elseif conditional2
    statements...
else
    statements...
end
```

There is no need for parentheses `()` or braces `{}`, and indentation is "only" to improve readability _(but readability is very important!)_.

Both `elseif` and `else` are optional, and there can be multiple `elseif` blocks.
However, the `end` is required.

It is possible to nest `if` statements, though you might want to help readability with the thoughtful use of parentheses, indents and comments.

The shortest form of an `if` statement would be something like this:

```julia
if n < 0
    n = 0
end
```

As a reminder: only expressions that evaluate to `true` or `false` can be used as conditionals.
Julia deliberately avoids any concept of "truthiness", so zero values, empty strings and empty arrays are _not_ equivalent to `false`. 

## Ternary operator

A simple and common situation is picking one of two values based on a conditional.

Julia, like many languages, has a ternary operator to make this more concise.

The syntax is `conditional ? value_if_true : value_if_false`.

So the previous example could be rewritten:

```julia
n = n < 0 ? 0 : n
```

Parentheses are not required by the compiler, but may improve readability.

[numeric-comparisons]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Numeric-Comparisons
[conditional-eval]: https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation