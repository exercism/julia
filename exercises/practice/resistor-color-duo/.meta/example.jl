COLORS = [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
]

function colorcode(colors)
    tens = value(colors[1])
    ones = value(colors[2])

    tens * 10 + ones
end

function value(color)
    findfirst(==(color), COLORS) - 1
end