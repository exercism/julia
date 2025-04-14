get_coordinate(line) = line[2]

convert_coordinate(coordinate) = Tuple(coordinate)

compare_records(azara_record, rui_record) = 
    convert_coordinate(get_coordinate(azara_record)) ∈ rui_record

function create_record(azara_record, rui_record)
    compare_records(azara_record, rui_record) || return ()
    
    treasure, coordinate = azara_record
    location, _, quadrant = rui_record
    (coordinate, location, quadrant, treasure)
end
