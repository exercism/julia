using Test

# import Test.@test_skip, Test.@test_broken

# # When testing the example solution, all tests must pass, even ones marked as skipped or broken.
# # The track user will not be affected by this.
# # Overwrite @test_skip, @test_broken with @test
# macro test_skip(ex)
#     @test eval(current_module(), ex)
# end

# macro test_broken(ex)
#     @test eval(current_module(), ex)
# end

# Store base path to cd back to it later
const path = pwd()

for exercise in readdir("exercises")
    # Allow only testing specified execises
    if !isempty(ARGS) && !(exercise in ARGS)
        continue
    end

    exercise_path = joinpath("exercises", exercise)
    isdir(exercise_path) || continue

    # Create an anonymous module so that exercises are tested in separate scopes
    m = Module()

    # runtests.jl includes the solution by calling `include("slug.jl")`
    # Our anonymous module doesn't have `include(s::String)` defined,
    # so we define our own. We manually include the example solution in our
    # anonymous module, so we can define `m.include(s::String)` to do nothing.
    Core.eval(m, :(include(s) = nothing))
    Base.include(m, joinpath(exercise_path, "example.jl"))
    Base.include(m, joinpath(exercise_path, "runtests.jl"))
end
