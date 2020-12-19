include("prime-factors.jl")
using Test

@testset "no factors" begin
    @test prime_factors(1) == []
end

@testset "prime number" begin
    @test prime_factors(2) == [2]
end

@testset "square of a prime" begin
    @test prime_factors(9) == [3, 3]
end

@testset "cube of a prime" begin
    @test prime_factors(8) == [2, 2, 2]
end

@testset "product of primes and non-primes" begin
    @test prime_factors(12) == [2, 2, 3]
end

@testset "product of primes" begin
    @test prime_factors(901255) == [5, 17, 23, 461]
end

@testset "factors include a large prime" begin
    @test prime_factors(93819012551) == [11, 9539, 894119]
end
