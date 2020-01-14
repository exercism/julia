# canonical version = 1.3.0
using Test
using LazyJSON
include("example.jl")

j = LazyJSON.value(String(read("canonical-data.json")))

for i in j["cases"]
    for j in i["cases"]
        des = String(j["description"])
        inp = j["input"]["number"]

        i["description"] == "Invalid inputs" ? exped = j["expected"]["error"] : exped = j["expected"]
        @testset "$des" begin
           @test classify(inp) == exped
        end
    end
end
