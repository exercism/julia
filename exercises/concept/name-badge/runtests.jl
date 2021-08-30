using Test

include("namebadge.jl")

@testset "Full data" begin
    @test badge(455, "Mary M. Brown", "MARKETING") == "[455] - Mary M. Brown - MARKETING"
end

@testset "Full data with mixed case department" begin
    @test badge(7, "Eneus", "Wizardry & Witchcraft") == "[7] - Eneus - WIZARDRY & WITCHCRAFT"
end

@testset "No ID" begin
    @test badge(nothing, "Amália Valéria Kóbor", "Security") == "Amália Valéria Kóbor - SECURITY"
end

@testset "Owner's Badge" begin
    @test badge(1, "Anna Johnson", nothing) == "[1] - Anna Johnson - OWNER"
end

@testset "Owner's Badge without ID" begin
    @test badge(nothing, "Elvira McFee", nothing) == "Elvira McFee - OWNER"
end
