using Base.Test

include("hello-world.jl")

@testset "no name" begin
    @test hello() == "Hello, World!"
end

@testset "names" begin
    @test hello("Alice") == "Hello, Alice!"
    @test hello("Bob") == "Hello, Bob!"
end
