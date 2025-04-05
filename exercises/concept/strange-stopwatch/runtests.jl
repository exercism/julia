using Test

include("strange-stopwatch.jl")

@testset verbose = true "tests" begin
    @testset "rotations" begin
        x, y = rotate(1, 0, π/2)
        @test isapprox(x, 0; atol=1e-2) && isapprox(y, 1; atol=1e-2)

        x, y = rotate(1, 0, -π/2)
        @test isapprox(x, 0; atol=1e-2) && isapprox(y, -1; atol=1e-2)

        x, y = rotate(1, 1, π)
        @test isapprox(x, -1; atol=1e-2) && isapprox(y, -1; atol=1e-2)

        x, y = rotate(2, 2, -π/3)
        @test isapprox(x, 2.73205; atol=1e-2) && isapprox(y, -0.73205; atol=1e-2)
    end

    @testset "time argument" begin
        @test isapprox(timearg(0, 1), 0; atol=1e-2)

        @test isapprox(timearg(2, 2), π/4; atol=1e-2)

        @test isapprox(timearg(0, -7), π; atol=1e-2)

        @test isapprox(timearg(-4, 0), 3π/2; atol=1e-2)

        @test isapprox(timearg(1, √3), π/6; atol=1e-2)
    end

    @testset "read time" begin
        minsec(strtime) = parse.(Float64, match(r"(\d+\.?\d*)m (\d+\.?\d*)s", strtime).captures)

        m, s = minsec(readtime(1, 0))
        @test isapprox(m, 1.0; atol=1e-9) && isapprox(s, 15.0; atol=1e-2)

        m, s = minsec(readtime(-4, 0))
        @test isapprox(m, 4.0; atol=1e-9) && isapprox(s, 45.0; atol=1e-2)

        m, s = minsec(readtime(0, -3))
        @test isapprox(m, 3.0; atol=1e-9) && isapprox(s, 30.0; atol=1e-2)

        m, s = minsec(readtime(√2, -√2))
        @test isapprox(m, 2.0; atol=1e-9) && isapprox(s, 22.5; atol=1e-2)
    end

    @testset "find timer coordinates" begin
        x, y = getcoords(1, 0)
        @test isapprox(x, 0; atol=1e-2) && isapprox(y, 1; atol=1e-2)

        x, y = getcoords(2, 15)
        @test isapprox(x, 2; atol=1e-2) && isapprox(y, 0; atol=1e-2)

        x, y = getcoords(3, 45)
        @test isapprox(x, -3; atol=1e-2) && isapprox(y, 0; atol=1e-2)

        x, y = getcoords(4, 37.5)
        @test isapprox(x, -2.8284; atol=1e-2) && isapprox(y, -2.8284; atol=1e-2)
    end
end
