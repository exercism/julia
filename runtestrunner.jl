using JSON

# Setup GHA logger in CI
using Logging: global_logger
using GitHubActions: GitHubActionsLogger, set_output
get(ENV, "GITHUB_ACTIONS", "false") == "true" && global_logger(GitHubActionsLogger())

# Dir to store generated test results in
results_dir = mktempdir(; prefix="jl_test-runner_results_", cleanup=false)

# In CI, set results directory as output
set_output("results-path", results_dir)

include("eachexercise.jl")

eachexercise(ARGS) do exercise, exercise_type, exercise_path, example_path
    @info "[$(uppercase(exercise_type))] Testing $exercise"

    # Determine file name of the solution
    meta_cfg = JSON.parsefile(joinpath(exercise_path, ".meta", "config.json"))
    solution_file = meta_cfg["files"]["solution"][1]

    # Copy solution to temporary directory
    tmp = mktempdir(; prefix="jl_$(exercise)_")
    cp(example_path, joinpath(tmp, solution_file))
    cp(joinpath(exercise_path, "runtests.jl"), joinpath(tmp, "runtests.jl"))

    # Run test-runner
    run(`docker run
            --network none
            --read-only
            --mount type=bind,src=$tmp,dst=/solution
            --mount type=bind,src=$tmp,dst=/output
            --mount type=tmpfs,dst=/tmp
            exercism/julia-test-runner $exercise /solution /output`
    )

    cp(joinpath(tmp, "results.json"), joinpath(results_dir, "$(exercise_type)_$exercise.json"))
end
