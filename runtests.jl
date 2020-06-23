using Test

for exercise in readdir("exercises")
    # Allow only testing specified execises
    if !isempty(ARGS) && !(exercise in ARGS)
        continue
    end

    exercise_path = joinpath("exercises", exercise)
    isdir(exercise_path) || continue

    # Create an anonymous module so that exercises are tested in separate scopes
    m = Module()

    # When testing the example solution, all tests must pass, even those that are marked as skipped or broken.
    # The student will not be affected by this.
    # Overwrite @test_skip and @test_broken with @test
    Core.eval(m, :(using Test))
    @eval m $(Symbol("@test_skip")) = $(Symbol("@test"))
    @eval m $(Symbol("@test_broken")) = $(Symbol("@test"))

    # runtests.jl includes the solution by calling `include("slug.jl")`
    # Our anonymous module doesn't have `include(s::String)` defined,
    # so we define our own. We manually include the example solution in our
    # anonymous module, so we can define `m.include(s::String)` to do nothing.
    Core.eval(m, :(include(s) = nothing))
    Base.include(m, joinpath(exercise_path, "example.jl"))
    @info "Testing $exercise"
    Base.include(m, joinpath(exercise_path, "runtests.jl"))
    
    # Check that all ipynb's are valid JSON
    # open("$exercise_path/$exercise.ipynb") do f
    #     string(JSON3.read(f))
    # end

    println() # to make the output more readable
end
