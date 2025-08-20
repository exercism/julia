function clothingitem(categories, qualities)
    Dict(categories[i] => qualities[i] for i in eachindex(categories))
end

function get_combinations(tops, bottoms)
    [(top, bottom) for top in tops, bottom in bottoms]
end

function get_prices(combos)
    [first(combo)["price"] + last(combo)["price"] for combo in combos]
end

function filter_clashing(combos)
    [combo for combo in combos if first(combo)["base_color"] ≠ last(combo)["base_color"]]
end
