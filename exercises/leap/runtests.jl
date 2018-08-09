using Test

include("leap.jl")

@testset "Year not divisible by 4: common year" begin
    @test !is_leap_year(2015)
end

@testset "Year divisible by 4, not divisible by 100: leap year" begin
    @test is_leap_year(2016)
end

@testset "Year divisible by 100, not divisible by 400: common year" begin
    @test !is_leap_year(2100)
end

@testset "Year divisible by 400: leap year" begin
    @test is_leap_year(2000)
end
