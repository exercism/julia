# Instructions

You work at an online fashion boutique store. 
You come up with the idea for a website feature where an outfit is suggested to the user. 
While you want to give lots of suggestions, you don't want to give bad suggestions, so you decide to use a comprehension since you can easily _generate_ outfit combinations, and _filter_ them by some criteria.

Clothing items are stored as a Dict:

```julia-repl
Dict(
  "item_name" => "Descriptive Name",
  "price" => 99.00,
  "color" => "Ochre Red",
  "base_color" => "red"
)
```

## 1. Suggest a combination

Implement `get_combinations()` to take a list of tops and a list of bottoms.
The function should return the `cartesian product` of the lists as a 2-dimensional array.
Each entry is a `(top, bottom)` combination as a tuple.
Tops change down the rows, bottoms change across the columns.

```julia-repl
julia> tops = [
         Dict("item_name" => "Dress shirt"),
         Dict("item_name" => "Casual shirt")
       ]
2-element Vector{Dict{String, String}}:
 Dict("item_name" => "Dress shirt")
 Dict("item_name" => "Casual shirt")

julia> bottoms = [
         Dict("item_name" => "Jeans"),
         Dict("item_name" => "Dress trousers")
       ]
2-element Vector{Dict{String, String}}:
 Dict("item_name" => "Jeans")
 Dict("item_name" => "Dress trousers")

julia> get_combinations(tops, bottoms)
2×2 Matrix{Tuple{Dict{String, String}, Dict{String, String}}}:
 (Dict("item_name"=>"Dress shirt"), Dict("item_name"=>"Jeans"))   (Dict("item_name"=>"Dress shirt"), Dict("item_name"=>"Dress trousers"))
 (Dict("item_name"=>"Casual shirt"), Dict("item_name"=>"Jeans"))  (Dict("item_name"=>"Casual shirt"), Dict("item_name"=>"Dress trousers"))
```

## 2. Filter out clashing outfits

Each piece of clothing has a `base_color` field.
Use this field to remove all combinations where the top and the bottom have the same base color.

```julia-repl
julia> tops = [
         Dict("item_name" => "Dress shirt", "base_color" => "blue", "price" => 35),
         Dict("item_name" => "Casual shirt", "base_color" => "black", "price" => 20)
       ]
2-element Vector{Dict{String, Any}}:
 Dict("price" => 35, "item_name" => "Dress shirt", "base_color" => "blue")
 Dict("price" => 20, "item_name" => "Casual shirt", "base_color" => "black")

julia> bottoms = [
         Dict("item_name" => "Jeans", "base_color" => "blue", "price" => 30),
         Dict("item_name" => "Dress trousers", "base_color" => "black", "price" => 75)
       ]
2-element Vector{Dict{String, Any}}:
 Dict("price" => 30, "item_name" => "Jeans", "base_color" => "blue")
 Dict("price" => 75, "item_name" => "Dress trousers", "base_color" => "black")

julia> filter_combinations(tops, bottoms)
1-element Vector{Tuple{Dict{String, Any}, Dict{String, Any}}}:
 (Dict("price" => 20, "item_name" => "Casual shirt", "base_color" => "black"), Dict("price" => 30, "item_name" => "Jeans", "base_color" => "blue"))
```

## 3. Filter by combination price

Each piece of clothing has a `price` field associated with it. 
While you want to give lots of suggestions, you want to be able to provide users an opportunity to select a price within their budget. 
Use the `maximum_price` keyword argument to filter out combinations where the price of the top and bottom exceed the maximum price.

If no maximum_price is specified, the default should be `100.00`

```julia-repl
julia> tops = [
         Dict("item_name" => "Dress shirt", "base_color" => "blue", "price" => 35),
         Dict("item_name" => "Casual shirt", "base_color" => "black", "price" => 20)
       ]
2-element Vector{Dict{String, Any}}:
 Dict("price" => 35, "item_name" => "Dress shirt", "base_color" => "blue")
 Dict("price" => 20, "item_name" => "Casual shirt", "base_color" => "black")

julia> bottoms = [
         Dict("item_name" => "Jeans", "base_color" => "blue", "price" => 30),
         Dict("item_name" => "Dress trousers", "base_color" => "black", "price" => 75)
       ]
2-element Vector{Dict{String, Any}}:
 Dict("price" => 30, "item_name" => "Jeans", "base_color" => "blue")
 Dict("price" => 75, "item_name" => "Dress trousers", "base_color" => "black")

julia> filter_combinations(tops, bottoms, maximum_price=50)
1-element Vector{Tuple{Dict{String, Any}, Dict{String, Any}}}:
 (Dict("price" => 20, "item_name" => "Casual shirt", "base_color" => "black"), Dict("price" => 30, "item_name" => "Jeans", "base_color" => "blue"))
```

## 4. Sort by combination price

Combinations passing task 3 should be returned in ascending order of combination price.

```julia-repl
# tops and bottoms are the same as the previous example, but the maximum_price is increased.

julia> filter_combinations(tops, bottoms, maximum_price=200)
2-element Vector{Tuple{Dict{String, Any}, Dict{String, Any}}}:
 (Dict("price" => 20, "item_name" => "Casual shirt", "base_color" => "black"), Dict("price" => 30, "item_name" => "Jeans", "base_color" => "blue"))
 (Dict("price" => 35, "item_name" => "Dress shirt", "base_color" => "blue"), Dict("price" => 75, "item_name" => "Dress trousers", "base_color" => "black"))
```
