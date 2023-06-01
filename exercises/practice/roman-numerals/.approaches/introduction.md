# Introduction

## General guidance

This exercise is usually solved with a lookup table of some kind.

Programmers often get the rules for roman numberals wrong and think that e.g. 8 should be written `IIX` rather than `VIII` because it is fewer characters.
The best known example of this is the completely broken `ROMAN()` function in Microsoft Excel.
If you're unsure about what the real rules for Roman numerals are, you can [read more here][standard-form].

## Example docstring

Sample docstring:

```julia
"""
    to_roman(n::Integer)

Return a Roman numeral for `n` as a `String`.

Numerals are written in the standard style, which is base 10 with 1-4
characters per digit. Digits are written with addition (e.g. "II" == 2), except
for digits 4 and 9 (e.g. 4 == "IV", 900 = "CM").

`n` must be in `1:3999` because the standard style does not have a symbol for
5000 (so we cannot express 4000) and because the standard style does not
support zero or negative numbers.

"""
```

## Approach: repeated subtraction

This is a slight edit of [taigua's solution](https://exercism.org/tracks/julia/exercises/roman-numerals/solutions/taigua).
This is a great solution because it is simple and efficient.

You might like to take a moment to study how it works for e.g. `to_roman(8)` and prove to yourself that it always produces the right answer.

```julia
const ROMANS = (
    (1000, "M"),
    (900 , "CM"),
    (500 , "D"),
    (400 , "CD"),
    (100 , "C"),
    (90 , "XC"),
    (50 , "L"),
    (40 , "XL"),
    (10 , "X"),
    (9 , "IX"),
    (5 , "V"),
    (4 , "IV"),
    (1 , "I")
)


function to_roman(number::Integer)
    if number <= 0
        error("number must be positive")
    end

    roman = ""
    for (k, v) in ROMANS
        while k <= number
            roman *= v
            number -= k
        end
    end
    roman
end
```

## Approach: `digits` and a 2D lookup table

This solution from cmcaine shows how you can use the standard library functions `Iterators.reverse`, `digits`, `enumerate` and `join` to help solve this exercise.

If you already know how those functions work, then it may be reasonably easy to follow and prove correct, especially with the large and obvious lookup table.

If you don't know how these functions work, now is a good time to learn!

`Iterators.reverse` is used instead of `reverse` because `enumerate` is a lazy iterator and `reverse` requires its argument to be indexable.

The table is a tuple of tuples instead of a matrix because Arrays in Julia are constructed at run-time, which is slower and unnecessary in this example.

```julia
const ireverse = Iterators.reverse

function to_roman1(n)
    n ∉ 1:3999 && error("n ∉ 1:3999")
    # table[i][d] gives the roman numeral for `d * 10^(i-1)`
    table = (
        ("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"),
        ("X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"),
        ("C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"),
        ("M", "MM", "MMM"))
    join(table[i][d] for (i, d) in ireverse(enumerate(digits(n))) if d != 0)
end
```

## Approach: encoding the rules with `if`

This solution from cmcaine encodes the rules of standard-form roman numerals in an inner function instead of using a larger lookup table.
It might be worth reading if you don't yet understand how the roman numerals are constructed.

```julia
const ireverse = Iterators.reverse

function to_roman2(n)
    n ∉ 1:3999 && error("n ∉ 1:3999")

    full = ('I', 'X', 'C', 'M')
    half = ('V', 'L', 'D')

    "Return roman numeral for `d * 10^(i-1)` as a String, d ∈ 0:9"
    function f(i, d)
        if d < 4
            full[i] ^ d
        elseif d == 4
            full[i] * half[i]
        elseif d == 9
            full[i] * full[i+1]
        else
            half[i] * (full[i] ^ (d - 5))
        end
    end

    join(f(i, d) for (i, d) in ireverse(enumerate(digits(n))))
end
```

`"foo" ^ i` repeats the string "foo" `i` times, which is consistent with Julia defining string multiplication as concatenation: `^` is exponentiation; which is multiplying a thing with itself; so exponentiating a string repeats it.

[standard-form]: https://en.wikipedia.org/wiki/Roman_numerals#Standard_form
