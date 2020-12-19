using Test

include("collatz-conjecture.jl")

# canonical data
@testset "Canonical data" begin
    @test collatz_steps(1) == 0
    @test collatz_steps(16) == 4
    @test collatz_steps(12) == 9
    @test collatz_steps(1000000) == 152
    @test_throws DomainError collatz_steps(0)
    @test_throws DomainError collatz_steps(-15)
end
