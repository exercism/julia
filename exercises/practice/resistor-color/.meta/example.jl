const COLORS = (
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
)

function colorcode(color)
    findfirst(==(color), COLORS) - 1
end

function colors()
    COLORS
end
