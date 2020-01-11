# This code generates the runtets.jl file automatically for some lucky exercises that work with this script.

# NOTE: This is a very experimental version of this idea. The code is not all that well written,
# and may not work on most exercises. If it works, it might save you hours of time writing that exercise.
# If it doesn't it will throw an error and quit.

using JSON, HTTP

# Get the exercise the user is working on from command line argument
current_exercise = ARGS[1]

# Download the test data for the exercise the user is working on and parse the JSON.
get_json = HTTP.get("https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/$current_exercise/canonical-data.json")
json_code = String(get_json.body)
data = JSON.parse(json_code)

# Create an array to push our julia code text to.
lines = []

# Write the initial two lines for runtets.jl
push!(lines, "# canonical data version: " * string(get(data, "version", nothing)) * "\n\nusing Test\n\n")
push!(lines, "include(\"$current_exercise.jl\")\n\n")


# For every testcase in the canonical data json file, write the test code
for testcases in get(data, "cases", nothing)

    # Get the function name that we want to test
    function_to_test = get(testcases, "property", nothing)

    # Write the testcase name, and description
    push!(lines, "@testset \"" * string(get(testcases, "description", nothing)) * "\" begin\n")

    # Get the parameters that need to be input into the function for testing
    inputParams = []
    for parameter in keys(get(testcases, "input", nothing))

        # If the parameters are arrays, format them as arrays in String
        # e.g. [a, b, c, d]
        if isa(get(get(testcases, "input", nothing), parameter, nothing), AbstractArray)
            # Start list string form
            listInStringForm = ["["]
            # Add every item in list to string list
            for item in get(get(testcases, "input", nothing), parameter, nothing)
                push!(listInStringForm, "\"", item, "\", ")
            end

            # Join the list into a string
            parameterTemp = String(join(listInStringForm))[1:lastindex(join(listInStringForm))-2]

            # End the list
            push!(inputParams, "$parameter = " *  parameterTemp * "]" * ", ")
            
        else

            # If parameters are not lists, get the parameters seperated by commas.
            push!(inputParams, "$parameter = " * string(get(get(testcases, "input", nothing), parameter, nothing)) * ", ")    
        end
    end

    # Finalise parameters to input into function
    inputTemp = String(join(inputParams))[1:lastindex(join(inputParams))-2]

    # Create expected output to compare with
    expectedOutput = []

    # If expected output is a dict, add items to expected output seperated by spaces
    if isa(get(testcases, "expected", nothing), Dict)
        for expectedThing in keys(get(testcases, "expected", nothing))
            push!(expectedOutput, get(get(testcases, "expected", nothing), expectedThing, nothing) , " ")
        end
        # Finalise expectedOutput
        expectedOutput = "\"" * join(expectedOutput) * "\""

    # If expected output is an array, write the array as a string like befor
    elseif isa(get(testcases, "expected", nothing), Array)
        expectedOutput = ["["]
        if length(get(testcases, "expected", nothing)) == 0
            expectedOutput = join(expectedOutput) * "]"
        else
            for expectedOutputItem in get(testcases, "expected", nothing)
                push!(expectedOutput, "\"$expectedOutputItem\", ")
            end
            expectedOutput = join(expectedOutput)[1:lastindex(join(expectedOutput))-2] * "]"
        end
    else
        # If expected output is not any a Dict or Array, just keep the expected output as a String
        expectedOutput = "\"" * get(testcases, "expected", nothing) * "\""
    end

    # Write the actual code that tests our function.
    push!(lines, "    @test $function_to_test(" * inputTemp * ") == " * strip(expectedOutput))
    push!(lines, "\nend\n\n")
end

# Finalise the runtests code, and show it.
linesJoin = join(lines)
println(linesJoin)