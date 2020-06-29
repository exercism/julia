# Template showing the use of GeneratorUtils, with default I/O stdin and stdout. The output
# is fine without modification on some exercises. Use the override! mechanism to control
# output (see docs in GeneratorUtils).

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
