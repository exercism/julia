using Test

include("secret-handshake.jl")

@testset "wink for 1" begin
    @test secret_handshake(1) == ["wink"]
end

@testset "double blink for 10" begin
    @test secret_handshake(2) == ["double blink"]
end

@testset "close your eyes for 100" begin
    @test secret_handshake(4) == ["close your eyes"]
end

@testset "jump for 1000" begin
    @test secret_handshake(8) == ["jump"]
end

@testset "combine two actions" begin
    @test secret_handshake(3) == ["wink", "double blink"]
end

@testset "reverse two actions" begin
    @test secret_handshake(19) == ["double blink", "wink"]
end

@testset "reversing one action gives the same action" begin
    @test secret_handshake(24) == ["jump"]
end

@testset "reversing no actions still gives no actions" begin
    @test secret_handshake(16) == []
end

@testset "all possible actions" begin
    @test secret_handshake(15) == ["wink", "double blink", "close your eyes", "jump"]
end

@testset "reverse all possible actions" begin
    @test secret_handshake(31) == ["jump", "close your eyes", "double blink", "wink"]
end

@testset "do nothing for zero" begin
    @test secret_handshake(0) == []
end

@testset "do nothing if lower 5 bits not set" begin
    @test secret_handshake(32) == []
end
