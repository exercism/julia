include("prime-factors.jl")
using Test

@testset "no factors" begin
    @test prime_factors(1) == []
end

@testset "prime number" begin
    @test prime_factors(2) == [2]
end

@testset "another prime number" begin
    @test prime_factors(3) == [3]
end

@testset "product of first prime" begin
    @test prime_factors(4) == [2, 2]
end

@testset "square of a prime" begin
    @test prime_factors(9) == [3, 3]
end

@testset "product of first and second prime" begin
    @test prime_factors(6) == [2, 3]
end

@testset "cube of a prime" begin
    @test prime_factors(8) == [2, 2, 2]
end

@testset "product of second prime" begin
    @test prime_factors(27) == [3, 3, 3]
end

@testset "product of primes and non-primes" begin
    @test prime_factors(12) == [2, 2, 3]
end

@testset "product of third prime" begin
    @test prime_factors(625) == [5, 5, 5, 5]
end

@testset "product of primes" begin
    @test prime_factors(901255) == [5, 17, 23, 461]
end

@testset "factors include a large prime" begin
    @test prime_factors(93819012551) == [11, 9539, 894119]
end
