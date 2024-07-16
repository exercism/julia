using Test

include("change.jl")

@testset verbose = true "tests" begin
    @testset "change for 1 cent" begin
        @test change([1, 5, 10, 25], 1) == [1]
    end

    @testset "single coin change" begin
        @test change([1, 5, 10, 25, 100], 25) == [25]
    end

    @testset "multiple coin change" begin
        @test change([1, 5, 10, 25, 100], 15) == [5, 10]
    end

    @testset "change with Lilliputian Coins" begin
        @test change([1, 4, 15, 20, 50], 23) == [4, 4, 15]
    end

    @testset "change with Lower Elbonia Coins" begin
        @test change([1, 5, 10, 21, 25], 63) == [21, 21, 21]
    end

    @testset "large target values" begin
        @test change([1, 2, 5, 10, 20, 50, 100], 999) == [2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100]
    end

    @testset "possible change without unit coins available" begin
        @test change([2, 5, 10, 20, 50], 21) == [2, 2, 2, 5, 10]
    end

    @testset "another possible change without unit coins available" begin
        @test change([4, 5], 27) == [4, 4, 4, 5, 5, 5]
    end

    @testset "a greedy approach is not optimal" begin
        @test change([1, 10, 11], 20) == [10, 10]
    end

    @testset "no coins make 0 change" begin
        @test change([1, 5, 10, 21, 25], 0) == []
    end

    @testset "error testing for change smaller than the smallest of coins" begin
        @test_throws DomainError change([5, 10], 3)
    end

    @testset "error if no combination can add up to target" begin
        @test_throws DomainError change([5, 10], 94)
    end

    @testset "cannot find negative change values" begin
        @test_throws DomainError change([1, 2, 5], -5)
    end
end
