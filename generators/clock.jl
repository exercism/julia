#!/usr/bin/env julia
# ARGS[1] points to the problem-specifications repo
# call with --project=generators

using JSON

p = joinpath(ARGS[1], "exercises", "clock", "canonical-data.json")
@debug "loading canonical data from $p"
const data = JSON.parsefile(p)

s  = "# canonical data version: $(data["version"]) (auto-generated)\n\n"
s *= "using Dates, Test\n\n"
s *= "include(\"$(data["exercise"]).jl\")\n\n"

parsetime(timestr) = Tuple(parse.(Int, split(timestr, ":")))

function parse_create(desc, input, expected)
    h, min = parsetime(expected)
    "    # $desc\n    @test Clock($(input["hour"]), $(input["minute"])) == Clock($h, $min)"
end

function parse_add(desc, input, expected; op = "+")
    h, min = parsetime(expected)
    "    # $desc\n    @test Clock($(input["hour"]), $(input["minute"])) $op Dates.Minute($(input["value"])) == Clock($h, $min)"
end

parse_sub(desc, input, expected) = parse_add(desc, input, expected; op = "-")

function parse_equal(desc, input, expected)
    c1 = (h=input["clock1"]["hour"], min=input["clock1"]["minute"])
    c2 = (h=input["clock2"]["hour"], min=input["clock2"]["minute"])

    neg = expected ? "=" : "!"

    "    # $desc\n    @test Clock($(c1.h), $(c1.min)) $neg= Clock($(c2.h), $(c2.min))"
end

function parse_show(desc, input, expected)
    "    @test sprint(show, Clock($(input["hour"]), $(input["minute"]))) == \"\\\"$expected\\\"\""
end

const mappings = Dict(
    "create" => parse_create,
    "add" => parse_add,
    "subtract" => parse_sub,
    "equal" => parse_equal,
    "show" => parse_show,
)

for case in data["cases"]
    global s
    s *= "@testset \"$(case["description"])\" begin\n"
    for c in case["cases"]
        s *= mappings[c["property"]](c["description"], c["input"], c["expected"]) * "\n\n"
    end
    s = s[1:end - 1] # Remove trailing newline
    s *= "end\n\n"
end

# showing clocks
s *= "@testset \"displaying clocks\" begin\n"
for c in data["cases"][1]["cases"]
    global s
    s *= mappings["show"](c["description"], c["input"], c["expected"]) * "\n"
end
s *= "end\n"

print(s)
