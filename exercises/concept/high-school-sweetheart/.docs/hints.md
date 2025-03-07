# Hints

## General

- Read about Function Composition in the [manual][function-composition-manual].
- Browse the [methods available for _Strings_][string-methods].

## 1. Clean up the name

- There is a [built-in method][string-replace] to replace all occurrences of a substring in a string.
- There is a [built-in method][string-strip] to remove leading and trailing whitespaces from a string.

## 2. Get the name's first letter

- To get a specific character from a string, you can use [indexing][string-indexing].
- The cleanest way to write this is by using the composition operator `∘`.

## 3. Format the first letter as an initial

- There is a [built-in method][string-uppercase] to convert all characters in a string to their uppercase variant.

## 4. Put the initials inside of the heart

- You can use unicode characters in strings by using: `'\u<id>'`, where, in the case of the heart emoji, the id is `2764`.
- This can be done with [concatenation][string-concatenation] or [interpolation][string-interpolation].

[function-composition-manual]: https://docs.julialang.org/en/v1/manual/functions/#Function-composition-and-piping
[string-methods]: https://docs.julialang.org/en/v1/base/strings/
[string-replace]: https://docs.julialang.org/en/v1/base/strings/#Base.replace-Tuple{IO,%20AbstractString,%20Vararg{Pair}}
[string-strip]: https://docs.julialang.org/en/v1/base/strings/#Base.strip
[string-indexing]: https://docs.julialang.org/en/v1/manual/strings/#String-Basics
[string-uppercase]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.uppercase
[stting-concatenation]: https://docs.julialang.org/en/v1/manual/strings/#man-concatenation
[string-interpolation]: https://docs.julialang.org/en/v1/manual/strings/#string-interpolation
