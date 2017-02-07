# Aliases: I = 1, V = 5, X = 10, L = 50, C = 100, D = 500, M = 1000.
function to_roman(number::Integer)
    number < 1 && error("Invalid number")
    alias = [
        ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"],
        ["X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"],
        ["C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"],
        ["M", "MM", "MMM"],
    ]
    i = 1
    result = []
    while number > 0
        j = rem(number, 10)
        if j > 0
            push!(result, alias[i][j])
        end
        i += 1
        number = div(number, 10)
    end
    join(reverse(result))
end
