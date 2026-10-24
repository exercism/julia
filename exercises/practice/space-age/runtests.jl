# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/space-age/canonical-data.json
# File last updated on 2026-10-24

using Test

include("space-age.jl")

@testset verbose = true "tests" begin
    @testset "age on Earth" begin
        @test isapprox(onEarth(1000000000), 31.69; rtol=0.01)
    end

    @testset "age on Mercury" begin
        @test isapprox(onMercury(2134835688), 280.88; rtol=0.01)
    end

    @testset "age on Venus" begin
        @test isapprox(onVenus(189839836), 9.78; rtol=0.01)
    end

    @testset "age on Mars" begin
        @test isapprox(onMars(2129871239), 35.88; rtol=0.01)
    end

    @testset "age on Jupiter" begin
        @test isapprox(onJupiter(901876382), 2.41; rtol=0.01)
    end

    @testset "age on Saturn" begin
        @test isapprox(onSaturn(2000000000), 2.15; rtol=0.01)
    end

    @testset "age on Uranus" begin
        @test isapprox(onUranus(1210123456), 0.46; rtol=0.01)
    end

    @testset "age on Neptune" begin
        @test isapprox(onNeptune(1821023456), 0.35; rtol=0.01)
    end
end
