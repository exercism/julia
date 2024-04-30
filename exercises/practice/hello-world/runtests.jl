using Test

include("hello-world.jl")

@testset verbose = true "tests" begin
    @testset "Say Hi!" begin
        @test hello() == "Hello, World!"
    end
end
