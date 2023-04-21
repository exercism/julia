using Test, Random

include("square-root.jl")


@testset "Different valid values" begin
    @testset "Square root of 1 is 1" begin
        @test isapprox(square_root(1; tol=1e-6), 1.0; atol=1e-6)
    end
    @testset "Square root of 4 is 2" begin
        @test isapprox(square_root(4; tol=1e-6), 2.0; atol=1e-6)
    end
    @testset "Square root of 25 is 5" begin
        @test isapprox(square_root(25; tol=1e-6), 5.0; atol=1e-6)
    end
    @testset "Square root of 81 is 9" begin
        @test isapprox(square_root(81; tol=1e-6), 9.0; atol=1e-6)
    end
    @testset "Square root of 196 is 14" begin
        @test isapprox(square_root(196; tol=1e-6), 14.0; atol=1e-6)
    end
    @testset "Square root of 65025 is 255" begin
        @test isapprox(square_root(65025; tol=1e-6), 255.0; atol=1e-6)
    end
    @testset "Domain error for negative number" begin
        @test_throws DomainError square_root(-65536; tol=1e-12)
    end
end


@testset "Random tests" begin
    for (s, e) in zip(rand(Int64, 10), rand(Float64, 10))
        @test isapprox(square_root(s^2; tol=e), s; atol=e)
    end
end
