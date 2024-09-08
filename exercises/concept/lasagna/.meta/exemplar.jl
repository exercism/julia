expected_bake_time = 60

preptime(layers) = 2 * layers

remaining_time(current_time) = expected_bake_time - current_time

total_working_time(layers, current_time) = preptime(layers) + current_time
