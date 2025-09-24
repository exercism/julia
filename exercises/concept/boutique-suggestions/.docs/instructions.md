# Instructions

You work at an online fashion boutique store. 
You come up with the idea for a website feature where outfits are suggested to the user.
Of interest are the potential outfits, their prices and eliminating clashing options.

~~~~exercism/note
While there may be different ways to solve the following problems, all can be solved with a comprehension.
~~~~

## 1. Create clothing item


Implement `clothingitem()` to take two `Tuple`s, one of `categories` and the other of their respective `qualities`.
The function should return a `Dict` with the `categories` as keys and `qualities` as values.

```julia-repl
julia> categories = ("item_name", "price", "color", "base_color");

julia> qualities = ("Descriptive Name", 99.00, "Ochre Red", "red");

julia> clothingitem(categories, qualities)
Dict{String, Any} with 4 entries:
  "price"      => 99.0
  "item_name"  => "Descriptive Name"
  "base_color" => "red"
  "color"      => "Ochre Red"
```

Your function should be able to handle any number of `categories`.

## 2. Suggest combinations

Implement `get_combinations()` to take a `Tuple` of tops and a `Tuple` of bottoms.
The function should return the `cartesian product` of the tuples as a 2-D array (i.e. `Matrix`).
Each entry is a `(top, bottom)` combination as a `Tuple`.
Tops change down the rows, bottoms change across the columns.

```julia-repl
julia> tops = (
        Dict("item_name" => "Dress shirt"),
        Dict("item_name" => "Casual shirt")
        );

julia> bottoms = (
        Dict("item_name" => "Jeans"),
        Dict("item_name" => "Dress trousers")
       );

julia> get_combinations(tops, bottoms)
2×2 Matrix{Tuple{Dict{String, String}, Dict{String, String}}}:
 (Dict("item_name"=>"Dress shirt"), Dict("item_name"=>"Jeans"))   (Dict("item_name"=>"Dress shirt"), Dict("item_name"=>"Dress trousers"))
 (Dict("item_name"=>"Casual shirt"), Dict("item_name"=>"Jeans"))  (Dict("item_name"=>"Casual shirt"), Dict("item_name"=>"Dress trousers"))
```

## 3. Add up outfit prices

Each piece of clothing has a `price` field associated with it, so it could be helpful to be able to compare the full price of outfits.
Implement `get_prices()` which takes an array of clothing combinations.
The function should return a similarly shaped array with the prices of the outfits in their respective positions.

```julia-repl
julia> tops = (
        Dict("item_name" => "Dress shirt", "base_color" => "blue", "price" => 35),
        Dict("item_name" => "Casual shirt", "base_color" => "black", "price" => 20)
       );

julia> bottoms = (
        Dict("item_name" => "Jeans", "base_color" => "blue", "price" => 30),
        Dict("item_name" => "Dress trousers", "base_color" => "black", "price" => 75)
       );

julia> combomatrix = get_combinations(tops, bottoms);

julia> get_prices(combomatrix)
2×2 Matrix{Int}::
 65  110
 50   95

julia> filteredmatrix = filter_clashing(combomatrix)
1-element Vector{Tuple{Dict{String, Any}, Dict{String, Any}}}:
 (Dict("price" => 20, "item_name" => "Casual shirt", "base_color" => "black"), Dict("price" => 30, "item_name" => "Jeans", "base_color" => "blue"))

julia> get_prices(filteredmatrix)
1-element Vector{Int}:
 50
```

## 4. Filter out clashing outfits

Each piece of clothing has a `base_color` field.
Use this field to remove all combinations where the top and the bottom have the same base color.
Implement `filter_clashing()` to take an array of clothing combinations.
Return a 1-D array (i.e. `Vector`) of the matching combinations.

```julia-repl
julia> tops = (
        Dict("item_name" => "Dress shirt", "base_color" => "blue", "price" => 35),
        Dict("item_name" => "Casual shirt", "base_color" => "black", "price" => 20)
       );

julia> bottoms = (
        Dict("item_name" => "Jeans", "base_color" => "blue", "price" => 30),
        Dict("item_name" => "Dress trousers", "base_color" => "black", "price" => 75)
       );

julia> combos = get_combinations(tops, bottoms);

julia> filter_clashing(combos)
1-element Vector{Tuple{Dict{String, Any}, Dict{String, Any}}}:
 (Dict("price" => 20, "item_name" => "Casual shirt", "base_color" => "black"), Dict("price" => 30, "item_name" => "Jeans", "base_color" => "blue"))
```
