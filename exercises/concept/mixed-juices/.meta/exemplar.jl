# This code is not really idiomatic.
# The assumption is that the exercise comes early in the syllabus, 
# before Dicts, broadcasting, comprehensions, etc


time_to_mix_juice(juice) =
    if juice == "Pure Strawberry Joy" 
        0.5
    elseif juice == "Energizer" || juice == "Green Garden"
        1.5
    elseif juice == "Tropical Island" 
        3
    elseif juice == "All or Nothing" 
        5
    else 
        2.5
    end

wedges_from_lime(size) =
    if size == "small"
        6
    elseif size == "medium"
        8
    else
        10
    end

function limes_to_cut(needed, limes)
    limes_cut = 0
    remaining = limes
    while needed > 0 && length(remaining) > 0
        needed -= wedges_from_lime(popfirst!(remaining))
        limes_cut += 1
    end
    limes_cut
end

function order_times(orders)
    times = []
    for order in orders
        push!(times, time_to_mix_juice(order))
    end
    times
end

function remaining_orders(time_left, orders)
    remaining = orders
    while time_left > 0 && length(orders) > 0
        time_left -= time_to_mix_juice(popfirst!(remaining))
    end
    remaining
end
