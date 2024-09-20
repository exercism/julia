# Hints

## General

- There are three [boolean operators][boolean-operators] to work with boolean values.
- Multiple operators can be combined in a single expression.

## 1. Check if a fast attack can be made

- The logical NOT operator (`!`) can be placed before an expression to negate its value.

## 2. Check if the group can be spied upon

- Boolean operators are typically used to evaluate whether two or more expressions are true or not true.

## 3. Check if the prisoner can be signaled

- Boolean operators execute in the order of their precedence (from highest to lowest): `!`, `&&`, `||`.
- In general, use of parentheses is encouraged to make your intention clearer.
- For more details check out the Operator Precedence section on the [official Julia documentation][operator-precedence].

[boolean-operators]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators
[operator-precedence]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity
