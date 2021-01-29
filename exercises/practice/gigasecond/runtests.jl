using Test
using Dates

include("gigasecond.jl")

samples = Dict(
    DateTime("2011-04-25") => DateTime("2043-01-01T01:46:40"),
    DateTime("1977-06-13") => DateTime("2009-02-19T01:46:40"),
    DateTime("1959-07-19") => DateTime("1991-03-27T01:46:40"),
    DateTime("2015-01-24T22:00:00") => DateTime("2046-10-02T23:46:40"),
    DateTime("2015-01-24T23:59:59") => DateTime("2046-10-03T01:46:39")
)

@testset "add gigasecond to $sample[1]" for sample in samples
    @test add_gigasecond(sample[1]) == sample[2]
end
