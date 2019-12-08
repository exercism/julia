
using Test

include("volume.jl")

@testset "0 input" begin
    @test sphere_vol(0) == 0.0
end

@testset "1 input" begin
    @test sphere_vol(1) == 4.1887902047863905
end

@testset "2 input" begin
    @test sphere_vol(2) == 33.510321638291124
end

@testset "3 input" begin
    @test sphere_vol(3) == 113.09733552923254
end

@testset "4 input" begin
    @test sphere_vol(4) == 268.082573106329
end

@testset "5 input" begin
    @test sphere_vol(5) == 523.5987755982989
end
