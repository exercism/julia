const expected_bake_time = 60

preparation_time(layers) = 2 * layers

remaining_time(current_time) = expected_bake_time - current_time

total_working_time(layers, current_time) = preparation_time(layers) + current_time
