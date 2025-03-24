# Hints

## 1. Replace any spaces encountered with underscores

- [Reference documentation][char-docs] for `Char`s is here.
- `Char` literals are enclosed in 'single quotes', `String` literals in "double quotes".

## 2. Remove all whitespace

- See [this method][isspace] for detecting whitespace characters and [this method][isdigit] for digits.

## 3. Convert camel-case to kebab-case

- See [this method][isuppercase] to check if a character is upper case.
- See [this method][lowercase] to convert a character to lower case.

## 5. Omit Greek lower case letters

- `Char`s support the default equality and comparison operators.

## 6. Combine these operations to operate on a string

- A string can be iterated over, in the same way as an array.
- To do all the transforms, consider using a comprehension.
- Multiple strings can be [joined][join] into one.

[char-docs]: https://docs.julialang.org/en/v1/manual/strings/#man-characters
[isspace]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.isspace
[isdigit]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.isdigit
[lowercase]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.lowercase
[isuppercase]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.isuppercase
[join]: https://docs.julialang.org/en/v1/base/strings/#Base.join
