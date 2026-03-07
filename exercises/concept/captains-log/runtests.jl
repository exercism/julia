# Many of these tests check properties of the result, rather than precise values
# With a big enough sample size (set in repeats variable),
#  the rate of false fails should be extremely low

using Test
using Random

include("captains-log.jl")

@testset verbose = true "tests" begin

    repeats = 10_000

    @testset "1. Generate a random planet" begin
        planetary_classes = ['D', 'H', 'J', 'K', 'L', 'M', 'N', 'R', 'T', 'Y']
        random_planets = [random_planet() for _ in 1:repeats]

        @testset "all generated planets are valid" begin
            @test all([p ∈ planetary_classes for p in random_planets])
        end

        @testset "all valid planets are generated" begin
            @test all([p ∈ random_planets for p in planetary_classes])
        end
    end

    @testset "2. Generate a random starship registry number" begin
        random_registry = [random_ship_registry_number() for _ in 1:repeats]

        @testset "all registry numbers are the correct length" begin
            @test all([length(regno) == 8 for regno in random_registry])
        end

        @testset "all registry numbers have the correct prefix" begin
            @test all([startswith(regno, "NCC-") for regno in random_registry])
        end

        @testset "all registry numbers have the correct numeric range" begin
            @test all([1000 ≤ parse(Int, regno[5:end]) ≤ 9999 for regno in random_registry])
        end
    end
    
    @testset "3. Generate a random stardate" begin
        random_stardates = [random_stardate() for _ in 1:repeats]

        @testset "stardates have the correct numeric range" begin
            @test all(41000 .<= random_stardates .<= 42000)
        end

        @testset "stardates are not all similar" begin
            n_small = sum(random_stardates .< 41333)
            n_mid = sum(41333 .< random_stardates .< 41667)
            n_large = sum(random_stardates .> 41667)
            n_expected = length(random_stardates) / 3
            
            uniform_if = sum(((n_small, n_mid, n_large) .- n_expected) .^ 2) / n_expected
            @test uniform_if < 6 # startdates should have uniform distribution
        end
    end

    @testset "4. Generate a rounded stardate" begin
        rounded_stardates = [random_stardate_v2() for _ in 1:repeats]

        @testset "stardates have the correct numeric range" begin
            @test all(41000 .<= rounded_stardates .<= 42000)
        end

        @testset "stardates are not all similar" begin
            n_small = sum(rounded_stardates .< 41333)
            n_mid = sum(41333 .< rounded_stardates .< 41667)
            n_large = sum(rounded_stardates .> 41667)
            n_expected = length(rounded_stardates) / 3

            uniform_if = sum(((n_small, n_mid, n_large) .- n_expected) .^ 2) / n_expected
            @test uniform_if < 6 # startdates should have uniform distribution
        end

        @testset "stardates have one decimal place" begin
            @test all([isapprox(stardate, round(stardate, digits=1), atol=1e-8)
                for stardate in rounded_stardates])
        end
    end

    @testset "5. Pick some random starships from a list" begin
        starships = unique([random_ship_registry_number() for _ in 1:100])
        lengths = rand(1:20, 100)
        chosen_starships = [pick_starships(copy(starships), len) for len in lengths]

        @testset "starships are taken from the input list" begin
            @test all([all([starship ∈ starships for starship in fleet]) for fleet in chosen_starships])
        end

        @testset "all chosen starships are unique" begin
            @test all([length(fleet) == length(unique(fleet)) for fleet in chosen_starships]) 
        end

        @testset "all chosen starship fleets are of correct size" begin
            @test all(length.(chosen_starships) .== lengths)
        end

        @testset "starships are chosen at random" begin
            @test all([sum(fleet .== starships[1:length(fleet)]) ≤ 3  for fleet in chosen_starships])
        end
    end

end
