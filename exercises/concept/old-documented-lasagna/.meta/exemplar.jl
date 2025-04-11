"""
    preptime(layers)

Return the preparation time in minutes.
"""
preptime(layers) = 2 * layers

"""
    remaining_time(current_time)

Return the remaining oven time in minutes.
"""
remaining_time(current_time) = 60 - current_time

"""
    total_working_time(layers, current_time)

Return the total working time in minutes.
"""
total_working_time(layers, current_time) = preptime(layers) + current_time
