get_vector_of_wagons(args...) = collect(args)

function fix_vector_of_wagons(each_wagons_id, missing_wagons)
    (first, second, locomotive, rest...) = each_wagons_id
    [locomotive, missing_wagons..., rest..., first, second]
end

function add_missing_stops(route, stops...)
    # Use a map() if you prefer
    stop_names = [stop.second for stop in stops]
    Dict(route..., "stops" => stop_names)
end

extend_route_information(route; more_route_information...) = merge(route, more_route_information)
