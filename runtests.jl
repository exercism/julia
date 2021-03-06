using Test

for exercise_type in ("concept", "practice")
    for exercise in readdir(joinpath("exercises", exercise_type))
        # Allow only testing specified exercises
        if !isempty(ARGS) && !(exercise in ARGS)
            continue
        end

        exercise_path = joinpath("exercises", exercise_type, exercise)
        isdir(exercise_path) || continue

        # Concept exercises have an exemplar, practice exercises merely an example for CI purposes
        example_or_exemplar = exercise_type == "concept" ? "exemplar" : "example"

        # Create an anonymous module so that exercises are tested in separate scopes
        m = Module()

        # When testing the example solution, all tests must pass, even those that are marked as skipped or broken.
        # The student will not be affected by this.
        # Overwrite @test_skip and @test_broken with @test
        @eval m using Test
        @eval m $(Symbol("@test_skip")) = $(Symbol("@test"))
        @eval m $(Symbol("@test_broken")) = $(Symbol("@test"))

        # runtests.jl includes the solution by calling `include("slug.jl")`
        # Our anonymous module doesn't have `include(s::String)` defined,
        # so we define our own.
        Core.eval(m, :(include(s) = $(Base.include)($m, $(joinpath(exercise_path, ".meta", example_or_exemplar * ".jl")))))
        @info "[$(uppercase(exercise_type))] Testing $exercise"
        Base.include(m, joinpath(exercise_path, "runtests.jl"))
        
        println() # to make the output more readable
    end
end
