# A script to generate example runtests.jl for exercises, using default settings for
# print_runtests from GeneratorUtils and adding in comments. Use this for testing and
# development, but to generate a proper runtests.jl, always review the exercise's
# canonical-data.json and adapt default_template.jl for that exercise, instead of using this
# script which might not be maintained.

# Usage:
# JULIA_LOAD_PATH=:[dir containing GeneratorUtils.jl] julia [this file] [path to problem-specifications/] [output dir]
# Example:
# dir='julia/generators/GeneratorUtils/' JULIA_LOAD_PATH=":$dir" julia "$dir/generate_defaults.jl" problem-specifications/ "$dir/generated_defaults/"

using GeneratorUtils

using DataStructures: OrderedDict
using JSON

const problems_dir = ARGS[1]
const out_dir = ARGS[2]

function print_comments(io::IO, canonical_data::AbstractDict)
    haskey(canonical_data, "comments") || return nothing
    println(io, """
        # The following lines are top-level comments in canonical-data.json; comments within cases
        # are not included. Do not include these comments in the exercise's runtests.jl.
        #"""
    )
    delim = ""
    for line in canonical_data["comments"]
        print(io, delim, "# ", line)
        delim = "\n"
    end
end

function main()
    exercises_dir = joinpath(problems_dir, "exercises/")
    isdir(exercises_dir) || throw(ArgumentError(exercises_dir * " does not exist."))
    mkpath(out_dir)

    @info "Printing runtests to $out_dir ..."
    count = 0
    for slug in readdir(exercises_dir)
        print(stderr, "\e[2K\r$slug")  # "\e[2K" is the ANSI control sequence to clear a line
        data_path = joinpath(exercises_dir, slug, "canonical-data.json")
        isfile(data_path) || continue
        open(data_path) do data_io
            canonical_data = tighten(JSON.parse(data_io; dicttype=OrderedDict))
            if haskey(canonical_data, "comments")
                override!(
                    canonical_data;
                    subheader=sprint(print_comments, canonical_data)
                )
            end
            open(joinpath(out_dir, slug * "_runtests.jl"), "w") do out_io
                print_runtests(out_io, canonical_data)
            end
        end
        count += 1
    end
    print(stderr, "\e[2K\r")
    @info "Done. $count runtests printed."
end

main()
