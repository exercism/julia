using Test

include("space-age.jl")

@testset verbose = true "Space Age" begin
    @testset "age on Earth" begin
        result = onEarth(1000000000)
        expected = 31.60
        @test isapprox(result, expected; rtol=0.01)
    end

    @testset "age on Mercury" begin
        result = onMercury(2134835688)
        expected = 280.88
        @test isapprox(result, expected; rtol=0.01)
    end

    @testset "age on Venus" begin
        result = onVenus(189839836)
        expected = 9.78
        @test isapprox(result, expected; rtol=0.01)
    end

    @testset "age on Mars" begin
        result = onMars(2129871239)
        expected = 35.88
        @test isapprox(result, expected; rtol=0.01)
    end

    @testset "age on Jupiter" begin
        result = onJupiter(901876382)
        expected = 2.41
        @test isapprox(result, expected; rtol=0.01)
    end

    @testset "age on Saturn" begin
        result = onSaturn(2000000000)
        expected = 2.15
        @test isapprox(result, expected; rtol=0.01)
    end

    @testset "age on Uranus" begin
        result = onUranus(1210123456)
        expected = 0.46
        @test isapprox(result, expected; rtol=0.01)
    end

    @testset "age on Neptune" begin
        result = onNeptune(1821023456)
        expected = 0.35
        @test isapprox(result, expected; rtol=0.01)
    end
end
