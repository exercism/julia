using Test

include("hello-world.jl")

@testset verbose = true "" begin
    @testset "Say Hi!" begin
        @test hello() == "Hello, World!"
    end
end
