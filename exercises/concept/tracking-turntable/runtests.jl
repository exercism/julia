using Test

include("tracking-turntable.jl")

@testset verbose = true "tests" begin
    @testset "complex from cartesian" begin
        @test z(1, 1) ≈ 1 + 1im

        @test z(4.5, -7.3) ≈ 4.5 - 7.3im

        @test z(-π, 42.24) ≈ -π + 42.24im
    end
    
    @testset "complex from polar" begin
        @test euler(1, π) ≈ -1.0 + 0.0im

        @test euler(3, π/2) ≈ 0.0 + 3.0im

        @test isapprox(euler(2, -π/4), √2 - √2im; atol=1e-2)

        @test isapprox(euler(2.5, -4π/3), -1.25 + 2.165im; atol=1e-2)
    end

    @testset "rotations" begin
        x, y = rotate(1, 0, π/2)
        @test isapprox(x, 0.0; atol=1e-2) && isapprox(y, 1.0; atol=1e-2)

        x, y = rotate(1, 0, -π/2)
        @test isapprox(x, 0.0; atol=1e-2) && isapprox(y, -1.0; atol=1e-2)

        x, y = rotate(1, 1, π)
        @test isapprox(x, -1.0; atol=1e-2) && isapprox(y, -1.0; atol=1e-2)

        x, y = rotate(2, 2, -π/3)
        @test isapprox(x, 2.73205; atol=1e-2) && isapprox(y, -0.73205; atol=1e-2)
    end

    @testset "radial displacements" begin
        x, y = rdisplace(0, 1, 1)
        @test isapprox(x, 0.0; atol=1e-2) && isapprox(y, 2.0; atol=1e-2)

        x, y = rdisplace(2, 0, -1)
        @test isapprox(x, 1.0; atol=1e-2) && isapprox(y, 0.0; atol=1e-2)

        x, y = rdisplace(1, 1, √2)
        @test isapprox(x, 2.0; atol=1e-2) && isapprox(y, 2.0; atol=1e-2)

        x, y = rdisplace(-2, 3.5, 1.2)
        @test isapprox(x, -2.595; atol=1e-2) && isapprox(y, 4.541; atol=1e-2)
    end

    @testset "find song" begin
        x, y = findsong(0, 1, 3, -π/2)
        @test isapprox(x, 4.0; atol=1e-2) && isapprox(y, 0.0; atol=1e-2)

        x, y = findsong(√2, √2, 0, 3π/4)
        @test isapprox(x, -2.0; atol=1e-2) && isapprox(y, 0.0; atol=1e-2)

        x, y = findsong(√2, √2, 3, 3π/4)
        @test isapprox(x, -5.0; atol=1e-2) && isapprox(y, 0.0; atol=1e-2)

        x, y = findsong(1/√2, 1/√2, 2, π/3)
        @test isapprox(x, -0.776; atol=1e-2) && isapprox(y, 2.898; atol=1e-2)
    end
end
