module Generators

using Dates
using HTTP
using JSON

struct TestData
    exercise::String
    comments::Union{Array{String}, Nothing}
    version::VersionNumber
    commit::String
    cases
end

function fetch_commit(exercise)
    url = "https://api.github.com/repos/exercism/problem-specifications/commits?path=exercises/$exercise/canonical-data.json"
    r = HTTP.request("GET", url, ["User-Agent" => "exercism/julia test generator"])
    json = (JSON.parse ∘ String)(r.body)
    json[1]["sha"][1:7]
end

function fetch_problem_spec(exercise)
    url = "https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/$exercise/canonical-data.json"
    r = HTTP.request("GET", url)
    json = (JSON.parse ∘ String)(r.body)

    comments = haskey(json, "comments") ? String.(json["comments"]) : nothing

    TestData(json["exercise"], comments, VersionNumber(json["version"]), fetch_commit(exercise), json["cases"])
end

function makeheader(data::TestData)
    """using Test

    include(\"$(data.exercise).jl\")
    """
end

function makefooter(data::TestData)
    """# If you run into any issues with the testsuite,
    # please include the following debug info in your bug report:
    
    # problem specifications version: $(data.version)
    # automatically generated $(Dates.format(Dates.now(UTC), dateformat"on yyyy-mm-dd at HH:MMZ"))
    # from exercism/problem-specifications#$(data.commit)
    """
end

end # module
