using Test

include("two-bucket.jl")

@testset verbose = true "tests" begin
    @testset "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one" begin
        @test twobucket(3, 5, 1, 1) == (4, 1, 5)
    end

    @testset "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two" begin
        @test twobucket(3, 5, 1, 2) == (8, 2, 3)
    end

    @testset "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one" begin
        @test twobucket(7, 11, 2, 1) == (14, 1, 11)
    end

    @testset "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two" begin
        @test twobucket(7, 11, 2, 2) == (18, 2, 7)
    end

    @testset "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two" begin
        @test twobucket(1, 3, 3, 2) == (1, 2, 0)
    end

    @testset "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two" begin
        @test twobucket(2, 3, 3, 1) == (2, 2, 2)
    end

    @testset "Not possible to reach the goal" begin
        @test_throws DomainError twobucket(6, 15, 5, 1) 
    end

    @testset "With the same buckets but a different goal, then it is possible" begin
        @test twobucket(6, 15, 9, 1) == (10, 2, 0)
    end

    @testset "Goal larger than both buckets is impossible" begin
        @test_throws DomainError twobucket(5, 7, 8, 1)
    end
end
