using JSON
using TOML

Base.:/(a::String, b::String) = joinpath(a, b)

function concept_exercises()
    base_path = "exercises" / "concept"
    collect(ex for ex in readdir(base_path) if isdir(base_path / ex))
end

function create_meta_configs()
    base_path = "exercises" / "concept"
    exercises = concept_exercises()

    Threads.@threads for exercise in exercises
        meta_path = base_path / exercise / ".meta"
        human_cfg = TOML.parsefile(meta_path / "config.toml")

        cfg = Dict(
            "language_versions" => "≥1.0",
            "files" => Dict(
                "test" => ["runtests.jl"],
                "exemplar" => [".meta/exemplar.jl"],
                "solution" => [isnothing(get(human_cfg, "solution", nothing)) ? "$exercise.jl" : human_cfg["solution"]],
            ),
            "authors" => [
                Dict("github_username" => x["github"], "exercism_username" => x["exercism"]) for x in human_cfg["authors"]
            ],
            "contributors" => [
                Dict("github_username" => x["github"], "exercism_username" => x["exercism"]) for x in human_cfg["contributors"]
            ],
            "forked_from" => get(human_cfg, "forked_from", []),
        )
        open(meta_path / "config.json", "w") do f
            JSON.print(f, cfg, 2)
        end
    end
end

function main()
    create_meta_configs()
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
