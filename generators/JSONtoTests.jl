using JSON, HTTP

currentExercise = ARGS[1]
getJSON = HTTP.get("https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/$currentExercise/canonical-data.json")
jsonCode = String(getJSON.body)
data = JSON.parse(jsonCode)

lines = []

push!(lines, "# canonical data version: " * get(data, "version", nothing) * "\n\nusing Test\n\n")
push!(lines, "include(\"$currentExercise.jl\")\n\n")

for testcases in get(data, "cases", nothing)
    functionToTest = get(testcases, "property", nothing)
    push!(lines, "@testset \"" * get(testcases, "description", nothing) * "\" begin\n")
    inputParams = []
    for parameter in keys(get(testcases, "input", nothing))
        if isa(get(get(testcases, "input", nothing), parameter, nothing), AbstractArray)
            listInStringForm = ["["]
            for item in get(get(testcases, "input", nothing), parameter, nothing)
                push!(listInStringForm, "\"", item, "\", ")
            end
            parameterTemp = String(join(listInStringForm))[1:lastindex(join(listInStringForm))-2]
            push!(inputParams, "$parameter = " *  parameterTemp * "]" * ", ")
            
        else
            push!(inputParams, "$parameter = " * get(get(testcases, "input", nothing), parameter, nothing) * ", ")    
        end
    
    end
    inputTemp = String(join(inputParams))[1:lastindex(join(inputParams))-2]
    expectedOutput = []
    if isa(get(testcases, "expected", nothing), Dict)
        for expectedThing in keys(get(testcases, "expected", nothing))
            push!(expectedOutput, get(get(testcases, "expected", nothing), expectedThing, nothing) , " ")
        end
        expectedOutput = "\"" * join(expectedOutput) * "\""
    elseif isa(get(testcases, "expected", nothing), Array)
        expectedOutput = ["["]
        for expectedOutputItem in get(testcases, "expected", nothing)
            push!(expectedOutput, "\"$expectedOutputItem\", ")
        end
        expectedOutput = join(expectedOutput)[1:lastindex(join(expectedOutput))-2] * "]"
    else
        expectedOutput = "\"" * get(testcases, "expected", nothing) * "\""
    end
    push!(lines, "    @test $functionToTest(" * inputTemp * ") == " * strip(expectedOutput) * "\n")
    push!(lines, "end\n\n")
end

linesJoin = join(lines)
println(linesJoin)