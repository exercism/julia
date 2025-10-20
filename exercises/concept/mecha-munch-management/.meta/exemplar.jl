function additems!(cart, items)
    foreach(item -> cart[item] = get(cart, item, 0) + 1, items)
    cart
end

update_recipes! = merge!

function send_to_store(cart, aisles)
    sort!([aisles[item] => cart[item] for item in keys(cart)])
end

function update_store_inventory!(inventory, cart)
    mergewith!(-, inventory, cart)
    filter(iszero ∘ last, inventory)
end

function reorder!(outofstock, stock)
    foreach(item -> outofstock[item] = get!(stock, item, 100), keys(outofstock))
    outofstock
end
