# Instructions

In this exercise, you will be managing an inventory system.

The inventory should be organized by the item name and it should keep track of the number of items available.

You will have to handle adding items to an inventory.
Each time an item appears in a given vector, the item's quantity should be increased by `1` in the inventory.
You will also have to handle deleting items from an inventory by decreasing quantities by `1` when requested.

Finally, you will need to implement a function that will return all the key-value pairs in a given inventory as a `vector` of `pair`s.


## 1. Create an inventory based on a vector

Implement the `create_inventory(<input vector>)` function that creates an "inventory" from an input vector of items.
It should return a `dict` containing each item name paired with their respective quantity.

```julia-repl
julia> create_inventory(["coal", "wood", "wood", "diamond", "diamond", "diamond"])
Dict("coal" => 1, "wood" => 2, "diamond" => 3)
```

## 2. Add items from a vector to an existing dictionary

Implement the `add_items(<inventory dict>, <item vector>)` function that adds a vector of items to the passed-in inventory:

```julia-repl
julia> add_items(Dict("coal" => 1), ["wood", "iron", "coal", "wood"])
Dict("coal" => 2, "wood" => 2, "iron" => 1)
```

## 3. Decrement items from the inventory

Implement the `decrement_items(<inventory dict>, <items vector>)` function that takes a `vector` of items.
Your function should remove `1` from an item count for each time that item appears on the `vector`:

```julia-repl
julia> decrement_items(Dict("coal" => 3, "diamond" => 1, "iron" => 5), ["diamond", "coal", "iron", "iron"])
Dict("coal" => 2, "diamond" => 0, "iron" => 3)
```

Item counts in the inventory should not be allowed to fall below 0.
If the number of times an item appears on the input `vector` exceeds the count available, the quantity listed for that item should remain at 0.
Additional requests for removing counts should be ignored once the count falls to zero.

```julia-repl
julia> decrement_items(Dict("coal" => 2, "wood" => 1, "diamond" => 2), ["coal", "coal", "wood", "wood", "diamond"])
Dict("coal" => 0, "wood" => 0, "diamond" => 1)
```

## 4. Remove an entry entirely from the inventory

Implement the `remove_item!(<inventory dict>, <item>)` function that removes an item and its count entirely from an inventory:

```julia-repl
julia> remove_item!(Dict("coal" => 2, "wood" => 1, "diamond" => 2), "coal")
Dict("wood" => 1, "diamond" => 2)
```

If the item is not found in the inventory, the function should return the original inventory unchanged.

```julia-repl
julia> remove_item!(Dict("coal" => 2, "wood" => 1, "diamond" => 2), "gold")
Dict("coal" => 2, "wood" => 1, "diamond" => 2)
```

## 5. Return the entire content of the inventory

Implement the `list_inventory(<inventory dict>)` function that takes an inventory and returns a vector of `(item, quantity)` pairs.

The vector should only include the _available_ items (_with a quantity greater than zero_), and should be sorted in alphabetical order of items:

```julia-repl
julia> list_inventory(Dict("coal" => 7, "wood" => 11, "diamond" => 2, "iron" => 7, "silver" => 0))
["coal" => 7, "diamond" => 2, "iron" => 7, "wood" => 11]
```
