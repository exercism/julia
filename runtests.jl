using JSON
using Pkg
using Test

# Setup GHA logger in CI
using Logging: global_logger
using GitHubActions: GitHubActionsLogger
get(ENV, "GITHUB_ACTIONS", "false") == "true" && global_logger(GitHubActionsLogger())

include("eachexercise.jl")

eachexercise(ARGS) do exercise, exercise_type, exercise_path, example_path
    # Skip exercise tests if the Julia version doesn't meet the required version as specified in .meta/config.json
    cfg = JSON.parsefile(joinpath(exercise_path, ".meta", "config.json"))
    required_version_spec = Pkg.Types.semver_spec(get(cfg, "language_versions", "1.0"))
    if VERSION ∉ required_version_spec
        @info "$exercise requires Julia $required_version_spec, skipping tests."
        println()
        return
    end

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
    @eval m include(s) = Base.include($m, $example_path)
    @info "[$(uppercase(exercise_type))] Testing $exercise"
    Base.include(m, joinpath(exercise_path, "runtests.jl"))

    println() # to make the output more readable
end
