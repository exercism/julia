function maximum_value(maximum_weight, items)
    # See https://en.wikipedia.org/wiki/Knapsack_problem#Dynamic_programming_in-advance_algorithm

    numitems = length(items)
    numitems == 0 && return 0

    # Remember, Julia uses 1-based array indexing
    # so maxes[r,c] indexing needs to be r+1, c+1, compared to the Wiki reference

    maxes = zeros(UInt16, numitems + 1, maximum_weight + 1)
    for item_count in 1:numitems
        for weight in 1:(maximum_weight)
            curr_weight = items[item_count].weight
            if curr_weight > weight
                # copy the row above, the new item is no use to us
                maxes[item_count + 1, weight + 1] = maxes[item_count, weight + 1]
            else
                # perhaps drop an old item, add the new one?
                replace_last = maxes[item_count, weight - curr_weight + 1] + items[item_count].value
                maxes[item_count + 1, weight + 1] = max(maxes[item_count, weight + 1], replace_last)
            end
        end
    end

    # converting to signed int is not essential, but it can help with debugging
    Int(maxes[end, end])
end
