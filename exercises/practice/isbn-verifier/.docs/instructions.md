# Instructions

The [ISBN-10 verification process](https://en.wikipedia.org/wiki/International_Standard_Book_Number) is used to validate book identification
numbers. These normally contain dashes and look like: `3-598-21508-8`

## ISBN

The ISBN-10 format is 9 digits (0 to 9) plus one check character (either a digit or an X only). In the case the check character is an X, this represents the value '10'. These may be communicated with or without hyphens, and can be checked for their validity by the following formula:

```
(x1 * 10 + x2 * 9 + x3 * 8 + x4 * 7 + x5 * 6 + x6 * 5 + x7 * 4 + x8 * 3 + x9 * 2 + x10 * 1) mod 11 == 0
```

If the result is 0, then it is a valid ISBN-10, otherwise it is invalid.

## Example

Let's take the ISBN-10 `3-598-21508-8`. We plug it in to the formula, and get:
```
(3 * 10 + 5 * 9 + 9 * 8 + 8 * 7 + 2 * 6 + 1 * 5 + 5 * 4 + 0 * 3 + 8 * 2 + 8 * 1) mod 11 == 0
```

Since the result is 0, this proves that our ISBN is valid.

## Task

Define a new `ISBN` type and a constructor for it that accepts a string.
The constructor should throw a `DomainError` if the provided string does not look like a valid ISBN-10.

The constructor should accept strings with and without separating dashes.

`ISBN` values should compare as equal if the ISBN-10s are the same and not otherwise, e.g.

```jl
ISBN("1-234-56789-X") == ISBN("123456789X") == ISBN("1234-56789X")
ISBN("1-234-56789-X") != ISBN("3-598-21508-8")
```

## Caveats

Converting from strings to numbers can be tricky in certain languages.
Now, it's even trickier since the check digit of an ISBN-10 may be 'X' (representing '10'). For instance `3-598-21507-X` is a valid ISBN-10.

## Bonus tasks

If you attempt these tasks please write your own tests for them in your solution file!

* Define a string macro so that `isbn"3-598-21507-X" == ISBN("3-598-21507-X")`.

* Let the constructor accept ISBN-13s as well. The same ISBN should compare equal regardless of format: `ISBN("1-234-56789-X") == ISBN("978-1-234-56789-7")`.

* Define a function or iterator to generate a valid ISBN, maybe even from a given starting ISBN.

* Can you store the ISBN as an integer rather than a string and would that ever be a good idea? If you did, could you still print the ISBN (including check-digit) as a string?
