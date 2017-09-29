using Base.Test

import Base.Test.@test_skip, Base.Test.@test_broken

# When testing the example solution, all tests must pass, even ones marked as skipped or broken.
# The track user will not be affected by this.
# Overwrite @test_skip, @test_broken with @test
macro test_skip(ex)
    @test eval(current_module(), ex)
end

macro test_broken(ex)
    @test eval(current_module(), ex)
end

for (root, dirs, files) in walkdir("exercises")
    for exercise in dirs
        # Allow only testing specified execises
        if !isempty(ARGS) && !(exercise in ARGS)
            continue
        end

        exercise_path = joinpath("exercises", exercise)

        # Create temporary directory
        temp_path = mktempdir(root)

        # Copy tests & example to the temporary directory
        cp(joinpath(exercise_path, "example.jl"), joinpath(temp_path, "$exercise.jl"))
        cp(joinpath(exercise_path, "runtests.jl"), joinpath(temp_path, "runtests.jl"))

        try
            # Run the tests
            @testset "$exercise example" begin
                # Run the tests within an anonymous module to prevent definitions from
                # one exercise leaking into another.
                eval(Module(), :(include(joinpath($temp_path, "runtests.jl"))))
            end
        finally
            # Delete the temporary directory
            rm(temp_path, recursive=true)
        end
    end
end
