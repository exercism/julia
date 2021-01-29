"""
    luhn(str)

Return true if `str` encodes a valid number in the luhn formula.

A valid string will:

 - Contain only 0-9 and space
 - Contain at least two numbers
 - After a transformation, the sum of the transformed digits will be evenly divisible by 10

The transformation is:

 - Every second digit, counting the rightmost digit as first, is doubled
 - If a doubled digit is greater than 9, subtract 9 from it.
"""
function luhn(str)
    acc = 0
    len = 0
    for chr in Iterators.reverse(str)
        if isdigit(chr)
            len += 1
            x = parse(Int, chr)
            acc += iseven(len) ? (2x < 10 ? 2x : 2x-9) : x
        elseif chr != ' '
            return false
        end
    end
    len > 1 ? acc % 10 == 0 : false
end
