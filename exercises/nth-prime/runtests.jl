using Test

include("nthprime.jl")
include("example.jl")


@testset "first prime" begin
    @test main(1) == 2
end

@testset "no zeroth" begin
    @test main(0) == "there is no zeroth prime"
end



@testset "second prime" begin
    @test main(2) == 3
end

@testset "sixth prime" begin
    @test main(6) == 13
end

@testset "big prime" begin
    @test main(10001) == 104743
end