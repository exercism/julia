# NOTE: This code is purely to test the coverage of the JSON to test converter.
# It prints the number of exercises that the script works on.

using JSON, HTTP

# Include the code we want to test the coverage of
include("JSONtoTests.jl")

# Print the slugs of the exercises that the code works on.
println("The converter works on the following exercises: ")

# Initialize an error counter to keep track of the number of exercises our script does not work on.
error_count = 0

# Initialize a counter for keeping track of how many exercises don't have canonical data in problem-specifications.
not_existing = 0

# Get all exercises and iterate over them
for i in readdir("../exercises")
    # Make error_count global to change its value in the try-catch block.
    global error_count
    global not_existing

    # Try to run the code on the exercise.
    try
        main(i)
        # If code works, then we can print the slug of the exercise. (slug is indented, and bulleted)
        println("-   $i")
    catch error
        # If exercise does not exist in problem-specifications repo, increment number of exercies
        # that are not on problem-specifications and move on.
        if isa(error,NotFoundException)
            not_existing += 1
            continue
        end
        # If code doesn't work, increment the error count, and continue to next exercise
        error_count += 1
        continue
    end
end

# Print final number of passes and fails.
println("Pass: $(length(readdir("../exercises")) - error_count - not_existing), Fail = $error_count, Neutral = $not_existing")