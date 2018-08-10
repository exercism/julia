using Test

import Test.@test_skip, Test.@test_broken

# When testing the example solution, all tests must pass, even ones marked as skipped or broken.
# The track user will not be affected by this.
# Overwrite @test_skip, @test_broken with @test
macro test_skip(ex)
    @test eval(current_module(), ex)
end

macro test_broken(ex)
    @test eval(current_module(), ex)
end

# Store base path to cd back to it later
const path = pwd()

for exercise in readdir("exercises")
    # Allow only testing specified execises
    if !isempty(ARGS) && !(exercise in ARGS)
        continue
    end

    exercise_path = joinpath("exercises", exercise)
    isdir(exercise_path) || continue

    # Create temporary directory
    temp_path = mktempdir()

    # Copy tests & example to the temporary directory
    cp(joinpath(exercise_path, "example.jl"), joinpath(temp_path, "$exercise.jl"))
    cp(joinpath(exercise_path, "runtests.jl"), joinpath(temp_path, "runtests.jl"))

    try
        @info "Testing $exercise"
        # Run the tests within their own Julia process to prevent definitions from
        # one exercise leaking into another.
        cd(temp_path)
        run(`julia --color=yes runtests.jl`)
        cd(path)
        println()
    finally
        # Delete the temporary directory
        rm(temp_path, recursive=true)
    end
end
