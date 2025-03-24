# Hints

## 1. Check how many birds visited today

- Todays's count is the last entry.

## 2. Increment today's count

- Modify the last entry in-place.
- Julia has a `+=` operator but not `++`.
- You must return the modified vector.

## 3. Check if there was a day with no visiting birds

- The `.==` operator tests for equality element-wise.
- The `any()` function may be useful.


## 4. Calculate the number of visiting birds for the first number of days

- Index with a range to get a subset of a vector.
- The `sum()` function takes vector input and returns a single number.


## 5. Calculate the number of busy days

- Logical indexing will give a subset of a vector, with entries matching the given condition.
- The condition must operate element-wise.
- Find the length of a vector with `length()`.


## 6. Calculate averages by day of the week

- Arithmetic (infix) operators can have a dot in front of the operator to convert them to element-wise operation.
