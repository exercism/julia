# Template showing the use of GeneratorUtils, with default I/O stdin and stdout. The output
# is fine without modification on some exercises. Use the override! mechanism to control
# output (see docs in GeneratorUtils).

# This script calls 'using GeneratorUtils', so make sure GeneratorUtils.jl is available from
# LOAD_PATH. For example, assuming the file is at GeneratorUtils/GeneratorUtils.jl, either
# call julia with the JULIA_LOAD_PATH environment variable set, like so (note the ':', which
# is important to make sure the path appends to rather than overwrites LOAD_PATH):
#   JULIA_LOAD_PATH=:GeneratorUtils/ julia [this file] < canonical_data.json > runtests.jl
# Or, within an interactive session:
#   push!(LOAD_PATH, "GeneratorUtils/")

using GeneratorUtils

using DataStructures: OrderedDict
using JSON

# Modify as desired.
const IO_IN = stdin
const IO_OUT = stdout

function main()
    # Use OrderedDicts to keep the order of function arguments for tests.
    canonical_data = tighten(JSON.parse(IO_IN; dicttype=OrderedDict))

    # for case in canonical_data["cases"]
    #     for subcase in case["cases"]
    #         override!(
    #             subcase,
    #             key=val
    #         )
    #     end
    # end

    print_runtests(IO_OUT, canonical_data)
end

main()
