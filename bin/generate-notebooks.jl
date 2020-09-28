#! julia

const BASEPATH = joinpath(@__DIR__, "..")

"Generate a Jupyter notebook for a given exercise."
function generate_notebook(slug)
    # readlines returns an array of strings.
    # Jupyter treats arrays of strings as multiline strings
    # but does not insert \n between elements of the array,
    # so it must be appended to each line manually.
    readme = readlines(joinpath(BASEPATH, "exercises", "$slug", "README.md")) .* "\n"
    stub = readlines(joinpath(BASEPATH, "exercises", "$slug", "$slug.jl")) .* "\n"
    tests = readlines(joinpath(BASEPATH, "exercises", "$slug", "runtests.jl")) .* "\n"

    # mark stub cell as to-be-submitted
    pushfirst!(stub, "# submit\n")

    # remove trailing newline at the end of each cell
    readme[end] = readme[end][1:end - 1]
    tests[end] = tests[end][1:end - 1]
    # not all exercises have stubs
    if !isempty(stub) 
        stub[end] = stub[end][1:end - 1]
    end

    # remove include($stub.jl) from the tests
    for (i, line) in enumerate(tests)
        tests[i] = replace(line, "include(\"$slug.jl\")" => "# include(\"$slug.jl\")")
    end

    unescape(lines) = replace(string(lines), "\\\$" => "\$")

    """
    {
        "cells": [
            {
                "cell_type": "markdown",
                "metadata": {},
                "source": $(unescape(readme))
            },
            {
                "cell_type": "markdown",
                "metadata": {},
                "source": ["## Your solution"]
            },
            {
                "cell_type": "code",
                "execution_count": null,
                "metadata": {},
                "outputs": [],
                "source": $(unescape(stub))
            },
            {
                "cell_type": "markdown",
                "metadata": {},
                "source": ["## Test suite"]
            },
            {
                "cell_type": "code",
                "execution_count": null,
                "metadata": {},
                "outputs": [],
                "source": $(unescape(tests))
            },
            {
                "cell_type": "markdown",
                "metadata": {},
                "source": [
                    "## Prepare submission\\n",
                    "To submit your exercise, you need to save your solution in a file called `$slug.jl` before using the CLI.\\n",
                    "You can either create it manually or use the following functions, which will automatically write every notebook cell that starts with `# submit` to the file `$slug.jl`.\\n"
                ]
            },
            {
                "cell_type": "code",
                "execution_count": null,
                "metadata": {},
                "outputs": [],
                "source": [
                    "# using Pkg; Pkg.add(\\\"Exercism\\\")\\n",
                    "# using Exercism\\n",
                    "# Exercism.create_submission(\\\"$slug\\\")"
                ]
            }
        ],
        "metadata": {
            "kernelspec": {
                "display_name": "Julia 1.3.0",
                "language": "julia",
                "name": "julia-1.3"
            },
            "language_info": {
                "file_extension": ".jl",
                "mimetype": "application/julia",
                "name": "julia",
                "version": "1.3.0"
            }
        },
        "nbformat": 4,
        "nbformat_minor": 2
    }
    """
end

function generate_notebooks()
    @info "Generating notebooks..."
    for slug in readdir(joinpath(BASEPATH, "exercises"))
        @debug "  $slug"
        outfile = joinpath(BASEPATH, "exercises", slug, "$slug.ipynb")
        write(outfile, generate_notebook(slug))
    end
    @info "Notebooks successfully generated"
end

generate_notebooks()
