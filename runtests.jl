using Base.Test

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
            result = @testset "$exercise example" begin
                include(joinpath(temp_path, "runtests.jl"))
            end
        finally
            # Delete the temporary directory
            rm(temp_path, recursive=true)
        end

        # Print test output (this is the default behaviour for older versions of Julia)
        if VERSION > v"0.6.0-dev"
            Base.Test.print_test_results(result)
        end
    end
end
