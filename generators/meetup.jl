# This is enough to generate some tests, but may not meet all track requirements

using Test
using Dates

using LazyJSON

dir = @__DIR__
jsonfileurl = "https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/meetup/canonical-data.json"
jsonfilename = "canonical-data.json"
jsonfile = download(jsonfileurl, joinpath(dir,jsonfilename))
outputfile = "parse_code.jl"
df = DateFormat("y-m-d")


f = LazyJSON.parse(read(joinpath(dir,jsonfile)))

CODE = """
using Test
using Dates

include("meetup.jl")

@testset verbose = true "tests" begin
"""

for i in f["cases"]
    des = String(i["description"])
    year = i["input"]["year"]
    month = i["input"]["month"]
    week = i["input"]["week"]
    dayofweek = i["input"]["dayofweek"]
    exped = i["expected"]
    property = i["property"]

    global CODE *= """

        @testset \"$des\" begin
            @test $(property)($(year), $(month), "$(week)", "$(dayofweek)") == Date("$(exped)", $(df))
        end
    """
end

global CODE *= """
end

"""

write(joinpath(dir,outputfile), CODE)
