# NOTE: This code is purely to test the coverage of the JSON to test converter.
# It prints the number of exercises that the script works on.

using JSON, HTTP

# Include the code we want to test the coverage of
include("JSONtoTests.jl")

# Print the names of the exercises that the code works on.
println("The converter works on the following exercises: ")

# Initialize an error counter to keep track of the number of exercises our script does not work on.
err = 0

# Get all exercises and iterate over them
for i in readdir("../exercises")
    # Make err global to change its value in the try-catch block.
    global err

    # Try to run the code on the exercise.
    try
        main(i)
        # If code works, then we can print the name of the exercise. (name is indented, and bulleted)
        println("-   $i")
    catch
        # If code doesn't work, increment the error count, and continue to next exercise
        err += 1
        continue
    end
end

# Print final number of passes and fails.
println("Pass: $(length(readdir("../exercises")) - err), Fail = $err")