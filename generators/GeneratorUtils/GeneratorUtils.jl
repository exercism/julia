# See default_template.jl for an example using this module.

module GeneratorUtils

using DataStructures: OrderedDict
using Printf

export camel_to_snake, exercism_format, expects_error, has_override, override!,
    print_runtests, tighten

const INDENT = ' '^4

"""
    tighten(collection) -> new_collection

Return a new collection with recursively tightened/narrowed container element types.

Starting from the innermost containers and proceeding outward, opy each container `a` into
an array with `collect(x for x in a)`, then apply the constructor for the type of the
`UnionAll` over parameters in `typeof(a)`. This copies the elements into a new container of
appropriate element type (see implementation of `Base.collect`). The original container and
its elements are unchanged.

This is useful for processing output from `JSON.parse`, which returns containers with
element type `Any`. The default output of `show(container)` is much cleaner when the
inferred type based on the elements is identical to the declared element type of the
container.

# Examples
```jldoctest
julia> using GeneratorUtils

julia> a = Pair{Any,Array}(Dict{Any,Tuple}(1 => (2, 3)), Integer[4])
Pair{Any,Array}(Dict{Any,Tuple}(1 => (2, 3)), Integer[4])

julia> tighten(a)
(Dict(1 => (2, 3)), [4])
```
"""
function tighten(a::T) where {T}
    Base.datatype_pointerfree(T) && return a  # not a container
    U = T.name.wrapper  # get the UnionAll over parameters in T
    return U(collect(tighten(x) for x in a))
end

tighten((a, b)::Pair) = (tighten(a), tighten(b))
tighten(a::String) = a

# If we use JSON.parse with OrderedDicts, make each of them look like a Dict when we print
# the tests. We don't want to just convert to a Dict because that removes order information
# which we print out. Note that vectors of OrderedDicts still show as OrderedDict[...]
# because that is dispatched to Base.show with type Vector{OrderedDict}. Out of the 115
# canonical-data.json currently available, Vector{OrderedDict} appears in 6 of them after
# parsing.
function Base.show(io::IO, dict::OrderedDict)
    @printf(io, "Dict(%s)", join(dict, ", "))
end

function exercism_format(x)
    x == [] && return "[]"  # "instead of "Any[]" or "T[]" in general
    return repr(x)  # use repr so that strings are quoted.
end

"""
    print_runtests(io::IO, canonical_data::AbstractDict)

Print the test data from `canonical_data` to `io`.

This first calls `print_header`, then calls `print_test` on every top-level test group in
`canonical_data`. `print_test` in turn calls itself as necessary on each sub-test group.

See (`override!`)[@ref] for a mechanism to override how each test is printed.
```
"""
function print_runtests(io::IO, canonical_data::AbstractDict)
    print_header(io, canonical_data)
    println(io)
    for case in canonical_data["cases"]
        print_test(io, case)
        println(io)
    end
end

"""
    override!(case::AbstractDict; key=value[, ...]) -> case

Override how parts of `case` are printed by the `print_` functions in `GeneratorUtils`.

If you wish to remove an entire test, use `delete!` instead on the entry in the parsed JSON.

There are two defaults that often require overrides:
- Using `JSON.jl`, all containers are parsed to `Vector`s and `[Abstract]Dict`s. If you need
  other containers like pairs and tuples, you can, for example, override `lhs` or `test` to
  provide them.
- All arguments are printed as positional arguments with variable names stripped. Again, use
  overrides to change this.

By default, tests are printed like so:

```julia
@testset [description] begin
    # If the test does not expect an error:
    @test [property]([input]...) == [expected]
    # If the test expects an error:
    @test_throws ArgumentError [property]([input]...)
end
```

# Arguments
- `case::AbstractDict`: A case from `canonical-data.json`, parsed into a dictionary (such as
  the output from `JSON.parse`).
- `key=value[, ...]`: A sequence of key-value pairs directing what to override.

# Keywords
The following keywords are currently in use (you can specify any number of them to override
specific parts of `case`):
- `subheader`: Printed just below the top-level header lines.
- `all`: Override an entire test set (should be a multi-line string beginning with
  `"@testset "`). This can be applied at any level (whether a top-level case or a subcase).
    - `description`: Override the description string from `case["description"]`.
    - `setup`: Printed just before a test or test set (e.g., to set up variables).
    - `test`: Override a single test (should be a string beginning with `@test ` or
      `@test_throws `). Defaults to `@test [lhs] == [rhs]` or
      `@test_throws [expected_error] [lhs]`.
        - `lhs`: Expression evaluated in the test. Defaults to `[property]([input])`
            - `property`: See `lhs`.
            - `input`: See `lhs`.
        - `rhs`: Expected output of `lhs`. This is mutually exclusive with `expected_error`.
        - `expected_error`: If `lhs` throws an exception, then this is the exception type.
          Defaults to `ArgumentError`.

# Implementation
Override directives are stored per case in a `Dict{Symbol,Any}` which can be accessed at
`case["override"]`. Methods that wish to use this override mechanism should call `override!`
to insert data, and call `has_override(case[, key])` to determine whether an override
directive exists for the symbol `key`. The interpretation is up to the method.

# Examples
```jldoctest
using GeneratorUtils
test_case = Dict(  # from parsing canonical-data.json
    "description" => "desc",
    "property" => "sqrt",
    "input" => Dict("x" => 81),
    "expected" => 9,
)
GeneratorUtils.print_test(stdout, test_case)
override!(
    test_case;
    description="new " * test_case["description"],
    input="-1",
    expected_error=DomainError,
)
GeneratorUtils.print_test(stdout, test_case)

# output
@testset "desc" begin
    @test sqrt(81) == 9
end
@testset "new desc" begin
    @test_throws DomainError sqrt(-1)
end
```
"""
function override!(case::AbstractDict; keyvals...)
    dict = get!(() -> Dict{Symbol,Any}(), case, "override")
    for (key, val) in keyvals
        dict[key] = val
    end
    return case
end

"""
    has_override(case::AbstractDict[, key::Symbol]) -> Bool

Check whether there is an override defined for symbol `key` in case `case`. If `key` is not
provided, then check whether there is any override at all for the case.
"""
has_override(case::AbstractDict) = haskey(case, "override")
has_override(case, key::Symbol) = has_override(case) && haskey(case["override"], key)

"""
    camel_to_snake(s::AbstractString)

Given a string in camelCase or PascalCase, return a copy in snake_case.
"""
function camel_to_snake(s::AbstractString)
    r = r"(?<!^)(?=[A-Z])"  # (?<!...) is a negative lookbehind, (?=...) is a positive lookahead
    return lowercase(replace(s, r => '_'))
end

"""
    expects_error(case::AbstractDict) -> Bool

Return `true` if the test case `case` expects an error instead of a value. This includes
checking for `expected_error` and `rhs` overrides.
"""
function expects_error(case::AbstractDict)
    return has_override(case, :expected_error) || (
        !has_override(case, :rhs) &&
        case["expected"] isa AbstractDict &&
        haskey(case["expected"], "error")
    )
end

function get_expected_error(case::AbstractDict)
    has_override(case, :expected_error) && return case["override"][:expected_error]
    return ArgumentError  # give a reasonable default if not overridden
end

function get_lhs(case::AbstractDict)
    has_override(case, :lhs) && return case["override"][:lhs]
    property = if has_override(case, :property)
        case["override"][:property]
    else
        camel_to_snake(case["property"])
    end
    input = if has_override(case, :input)
        case["override"][:input]
    else
        join(exercism_format.(values(case["input"])), ", ")
    end
    return @sprintf("%s(%s)", property, input)
end

function get_rhs(case::AbstractDict)
    has_override(case, :rhs) && return case["override"][:rhs]
    return exercism_format(case["expected"])
end

function get_description(case::AbstractDict)
    has_override(case, :description) && return case["override"][:description]
    return case["description"]
end

function print_header(io::IO, canonical_data::AbstractDict)
    @printf(io, "# canonical data version: %s\n", canonical_data["version"])
    print(io, "# This file was generated by a script.\n\n")
    print(io, "using Test\n\n")
    @printf(io, """include("%s.jl")\n""", canonical_data["exercise"])
    has_override(canonical_data, :subheader) && println(io, '\n', canonical_data["override"][:subheader])
end

indent(s::AbstractString) = replace(s, r"^"m => INDENT)

function indent_print(io::IO, f, args...)
    for line in eachline(IOBuffer(sprint(f, args...)))
        println(io, INDENT, line)
    end
end

function print_test(io::IO, case::AbstractDict)
    has_override(case, :all) && return println(io, case["override"][:all])
    @printf(io, """@testset "%s" begin\n""", get_description(case))
    has_override(case, :setup) && println(io, indent(case["override"][:setup]))
    if haskey(case, "cases")  # it's a test group
        for subcase in case["cases"]
            indent_print(io, print_test, subcase)
        end
    else  # it's a single test
        if has_override(case, :test)
            println(io, indent(case["override"][:test]))
        elseif expects_error(case)
            @printf(io, "%s@test_throws %s %s\n", INDENT, get_expected_error(case), get_lhs(case))
        else
            @printf(io, "%s@test %s == %s\n", INDENT, get_lhs(case), get_rhs(case))
        end
    end
    println(io, "end")
end

end
