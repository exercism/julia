# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/gigasecond/canonical-data.json
# File last updated on 2026-10-24

using Test
using Dates

include("gigasecond.jl")

@testset verbose = true "tests" begin
    @testset "date only specification of time" begin
        @test add_gigasecond(DateTime("2011-04-25")) == DateTime("2043-01-01T01:46:40")
    end

    @testset "second test for date only specification of time" begin
        @test add_gigasecond(DateTime("1977-06-13")) == DateTime("2009-02-19T01:46:40")
    end

    @testset "third test for date only specification of time" begin
        @test add_gigasecond(DateTime("1959-07-19")) == DateTime("1991-03-27T01:46:40")
    end

    @testset "full time specified" begin
        @test add_gigasecond(DateTime("2015-01-24T22:00:00")) ==
              DateTime("2046-10-02T23:46:40")
    end

    @testset "full time with day roll-over" begin
        @test add_gigasecond(DateTime("2015-01-24T23:59:59")) ==
              DateTime("2046-10-03T01:46:39")
    end
end
