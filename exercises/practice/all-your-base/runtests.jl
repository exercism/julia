using Test

include("all-your-base.jl")

@testset "single bit one to decimal" begin
    @test all_your_base([1], 2, 10) == [1]
end

@testset "binary to single decimal" begin
    @test all_your_base([1, 0, 1], 2, 10) == [5]
end

@testset "single decimal to binary" begin
    @test all_your_base([5], 10, 2) == [1, 0, 1]
end

@testset "binary to multiple decimal" begin
    @test all_your_base([1, 0, 1, 0, 1, 0], 2, 10) == [4, 2]
end

@testset "decimal to binary" begin
    @test all_your_base([4, 2], 10, 2) == [1, 0, 1, 0, 1, 0]
end

@testset "trinary to hexadecimal" begin
    @test all_your_base([1, 1, 2, 0], 3, 16) == [2, 10]
end

@testset "hexadecimal to trinary" begin
    @test all_your_base([2, 10], 16, 3) == [1, 1, 2, 0]
end

@testset "15-bit integer" begin
    @test all_your_base([3, 46, 60], 97, 73) == [6, 10, 45]
end

@testset "empty list" begin
    @test all_your_base([], 2, 10) == [0]
end

@testset "single zero" begin
    @test all_your_base([0], 10, 2) == [0]
end

@testset "multiple zeros" begin
    @test all_your_base([0, 0, 0], 10, 2) == [0]
end

@testset "leading zeros" begin
    @test all_your_base([0, 6, 0], 7, 10) == [4, 2]
end

@testset "input base is one" begin
    @test_throws DomainError all_your_base([0], 1, 10)
end

@testset "input base is zero" begin
    @test_throws DomainError all_your_base([], 0, 10)
end

@testset "input base is negative" begin
    @test_throws DomainError all_your_base([1], -2, 10)
end

@testset "negative digit" begin
    @test_throws DomainError all_your_base([1, -1, 1, 0, 1, 0], 2, 10)
end

@testset "invalid positive digit" begin
    @test_throws DomainError all_your_base([1, 2, 1, 0, 1, 0], 2, 10)
end

@testset "output base is one" begin
    @test_throws DomainError all_your_base([1, 0, 1, 0, 1, 0], 2, 1)
end

@testset "output base is zero" begin
    @test_throws DomainError all_your_base([7], 10, 0)
end

@testset "output base is negative" begin
    @test_throws DomainError all_your_base([1], 2, -7)
end

@testset "both bases are negative" begin
    @test_throws DomainError all_your_base([1], -2, -7)
end
