function label(colors)
    @assert length(colors) == 3
    color_key = ("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
    metric_prefixes = ("", "kilo", "mega", "giga")

    color_idx(i) = findfirst(==(colors[i]), color_key) - 1

    tens = color_idx(1)
    units = color_idx(2)
    exponent = color_idx(3)
    ohms = (10tens + units) * 10^exponent

    power_of_1000 = log10(ohms) ÷ 3
    prefix = metric_prefixes[power_of_1000 + 1]
    mantissa = ohms / 1000^power_of_1000

    # We want to print the mantissa without a trailing .0 if it is an integer.
    # The easiest way to get Julia to do that is to convert it to an Int.
    if isinteger(mantissa)
        mantissa = Int(mantissa)
    end
    return "$mantissa $(prefix)ohms"
end
