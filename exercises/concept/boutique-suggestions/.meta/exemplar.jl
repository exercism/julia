# 1) Copying Elixir: use Dicts and array comprehensions

get_combinations(tops, bottoms) = [(top, bottom) for top in tops, bottom in bottoms]

function filter_combinations(tops, bottoms; maximum_price=100.0)
    unclashed = [(top, bottom, top["price"] + bottom["price"]) 
                    for (top, bottom) in get_combinations(tops, bottoms) 
                    if top["base_color"] != bottom["base_color"] && 
                        top["price"] + bottom["price"] <= maximum_price]
    [(top, bottom) for (top, bottom, _) in sort(unclashed, by=x->x[3])]
end

# 2) use composite types and comprehensions

struct Garment
    item_name::String
    price::Number
    color::String
    base_color::String
end

get_combinations2(tops, bottoms) = [(top, bottom) for top in tops, bottom in bottoms]

function filter_combinations2(tops, bottoms; maximum_price=100.0)
    unclashed = [(top, bottom, top.price + bottom.price) 
                for (top, bottom) in get_combinations(tops, bottoms) 
                if top.base_color != bottom.base_color && 
                    top.price + bottom.price <= maximum_price]
    [(top, bottom) for (top, bottom, _) in sort(unclashed, by=x->x[3])]
end
