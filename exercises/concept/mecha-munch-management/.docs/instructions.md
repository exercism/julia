# Instructions

Mecha Munch™, a grocery shopping automation company has just hired you to work on their ordering app.
Your team is tasked with building an MVP (_[minimum viable product][mvp]_) that manages all the basic shopping cart activities, allowing users to add, remove, and sort their grocery orders.
Thankfully, a different team is handling all the money and check-out functions!

## 1. Add Item(s) to the User's Shopping Cart

The MVP should allow the user to add items to their shopping cart.
This could be a single item or multiple items at once.
Since this is an MVP, item quantity is indicated by _repeats_.
If a user wants to add 2 Oranges, 'Oranges' will appear twice in the input iterable.
If the user already has the item in their cart, the cart quantity should be increased by 1.
If the item is _new_ to the cart, it should be added with a quantity of 1.

Create the function `add_items!(<cart>, <items>)` that takes a cart dictionary and an iterable of items to add as arguments.
It should return the updated shopping cart dictionary for the user.

```julia-repl
julia> additems!(Dict("Banana" => 3, "Apple" => 2, "Orange" => 1),
                 ("Apple", "Apple", "Orange", "Apple", "Banana"))
Dict{String, Int64} with 3 entries:
  "Apple"  => 5
  "Orange" => 2
  "Banana" => 4

julia> additems!(Dict("Banana" => 3, "Apple" => 2, "Orange" => 1),
                 ["Banana", "Orange", "Blueberries", "Banana"])
Dict{String, Int64} with 4 entries:
  "Blueberries" => 1
  "Apple"       => 2
  "Orange"      => 2
  "Banana"      => 5
```

## 2. Update Recipe "Ideas" Section

The app has an "ideas" section that's filled with finished recipes from various cuisines.
The user can select any one of these recipes and have all its ingredients added to their shopping cart automatically.
The project manager has asked you create a way to edit these "ideas" recipes, since the content team keeps changing around ingredients and quantities.

Create the function `update_recipes!(<ideas>, <updates>)` that takes an "ideas" dictionary and a dictionary of recipe updates as arguments.
The function should return the updated "ideas" dictionary.

```julia-repl
julia>update_recipes!(
        Dict("Banana Bread"  => Dict("Banana" => 1, "Apple" => 1, "Walnuts" => 1, "Flour" => 1, "Eggs" => 2, "Butter" => 1),
             "Raspberry Pie" => Dict("Raspberry" => 1, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1)),
        Dict("Banana Bread" => Dict("Banana" => 4,  "Walnuts" => 2, "Flour" => 1, "Butter" => 1, "Milk" => 2, "Eggs" => 3))
    )
Dict{String, Dict{String, Int64}} with 2 entries:
  "Raspberry Pie" => Dict("Cream Custard"=>1, "Raspberry"=>1, "Orange"=>1, "Pie Crust"=>1)
  "Banana Bread"  => Dict("Eggs"=>3, "Flour"=>1, "Milk"=>2, "Butter"=>1, "Walnuts"=>2, "Banana"=>4)

julia> update_recipes!(
    Dict("Banana Bread"    => Dict("Banana" => 1, "Apple" => 1, "Walnuts" => 1, "Flour" => 1, "Eggs" => 2, "Butter" => 1),
         "Raspberry Pie"   => Dict("Raspberry" => 1, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1),
         "Pasta Primavera" => Dict("Eggs" => 1, "Carrots" => 1, "Spinach" => 2, "Tomatoes" => 3, "Parmesan" => 2, "Milk" => 1, "Onion" => 1)),
    Dict("Raspberry Pie"    => Dict("Raspberry" => 3, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1, "Whipped Cream" => 2),
        "Pasta Primavera"   => Dict("Eggs" => 1, "Mixed Veggies" => 2, "Parmesan" => 2, "Milk" => 1, "Spinach" => 1, "Bread Crumbs" => 1),
        "Blueberry Crumble" => Dict("Blueberries" => 2, "Whipped Creme" => 2, "Granola Topping" => 2, "Yogurt" => 3))
    )
Dict{String, Dict{String, Int64}} with 4 entries:
  "Raspberry Pie"     => Dict("Raspberry"=>3, "Orange"=>1, "Pie Crust"=>1, "Cream Custard"=>1, "Whipped Cream"=>2)
  "Pasta Primavera"   => Dict("Eggs"=>1, "Mixed Veggies"=>2, "Parmesan"=>2, "Milk"=>1, "Spinach"=>1, "Bread Crumbs"=>1)
  "Blueberry Crumble" => Dict("Blueberries"=>2, "Whipped Creme"=>2, "Granola Topping"=>2, "Yogurt"=>3)
  "Banana Bread"      => Dict("Banana"=>1, "Apple"=>1, "Walnuts"=>1, "Flour"=>1, "Eggs"=>2, "Butter"=>1)
```

## 3. Send User Shopping Cart to Store for Fulfillment

The app needs to send a given users cart to the store for fulfillment.
However, the shoppers in the store need to know where the item can be found using a unique aisle code.
The "fulfillment cart" needs to be sorted in order of the items aisle codes to help the shoppers be more efficient.

Create the function `send_to_store(<cart>, <aislecodes>)` that takes a user shopping cart and a dictionary that has store aisle numbers.
The function should return a combined "fulfillment cart" that has a pair `aislecode => quantity` for each item the customer is ordering.
Items should appear in the order of their aisle codes.

```julia-repl
julia> cart = Dict("Orange" => 1, "Milk" => 2, "Banana" => 3, "Apple" => 2, "Chocolate" => 2);

julia> aislecodes = Dict("Orange" => 2.4, "Milk" => 3.3, "Banana" => 2.6, "Apple" => 2.2, "Chocolate" => 5.7);

julia> send_to_store(cart, aislecodes)
5-element Vector{Pair{Float64, Int64}}:
 2.2 => 2
 2.4 => 1
 2.6 => 3
 3.3 => 2
 5.7 => 2
```

## 4. Update the Store Inventory to Reflect what a User Has Ordered.

The app can't just place customer orders endlessly.
Eventually, the store is going to run out of various products.
So your app MVP needs to update the store inventory every time a user sends their order to the store.
Otherwise, customers will order products that aren't actually available.

Create the function `update_store_inventory!(<inventory>, <cart>)` that takes a `cart` and an `inventory`.
The function should reduce the store inventory amounts by the number "ordered" in the "cart" and then return a dictionary of any items that are out of stock (i.e. which have reached `0`).

```julia-repl
julia> inventory = Dict("Banana" => 15, "Apple" => 12, "Orange" => 1, "Milk" => 4);

julia> cart = Dict("Orange" => 1, "Milk" => 2, "Banana" => 3, "Apple" => 2);

julia> update_store_inventory!(inventory, cart)
Dict{String, Int64} with 1 entry:
  "Orange" => 0

julia> inventory
Dict{String, Int64} with 4 entries:
  "Milk"   => 2
  "Apple"  => 10
  "Orange" => 0
  "Banana" => 12
```

## 5. Reorder Out-of-Stock Items.

Beyond updating the inventory, your app can help with restocking it.
Your MVP should be able to prepare a mini-order of any items which are out of stock after a customer's order.
This will help make triggering a major order simpler.
What's more, sometimes there are limited-time promotional items that are not in the stock list.
If these have sold out before the promotional period ends, they have proven popular and can be added to the stock list.

Create the `reorder!(<outofstock>, <stock>)` that takes `outofstock` and `stock`.
The `stock` dictionary contains standard stock items and their reorder quantities.
The `outofstock` dictionary is the result of `update_store_inventory!`, namely a dictionary of items with zero quantity.
The `outofstock` quantities should be updated to reflect those in `stock` and returned.
Also, any items in `outofstock` that are not present in `stock` should be added to `stock` with a default quantity of `100`.

```julia-repl
julia> inventory = Dict("Banana" => 15, "Apple" => 12, "Orange" => 1, "Milk" => 4, "Chocolate" => 2);

julia> cart = Dict("Orange" => 1, "Milk" => 2, "Banana" => 3, "Apple" => 2, "Chocolate" => 2);

julia> stock = Dict("Banana" => 150, "Apple" => 120, "Orange" => 120, "Milk" => 45);

julia> outofstock = update_store_inventory!(inventory, cart)
Dict{String, Int64} with 1 entry:
  "Orange"    => 0
  "Chocolate" => 0

julia> reorder!(outofstock, stock)
Dict{String, Int64} with 1 entry:
  "Orange"    => 120
  "Chocolate" => 100

julia> stock 
Dict{String, Int64} with 5 entries:
  "Milk"      => 45
  "Apple"     => 120
  "Chocolate" => 100
  "Orange"    => 120
  "Banana"    => 150
```

[mvp]: https://en.wikipedia.org/wiki/Minimum_viable_product
