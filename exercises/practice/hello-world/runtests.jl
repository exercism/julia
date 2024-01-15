using Test

include("hello-world.jl")

@testset verbose = true "Hello World" begin
    @testset "Say Hi!" begin
        @test hello() == "Hello, World!"
    end
end
