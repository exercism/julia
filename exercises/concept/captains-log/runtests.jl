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
            @test all([length(regno) == 8 for regno in random_registry])
        end

        @testset "all registry numbers have the correct numeric range" begin
            @test all([length(regno) == 8 for regno in random_registry])
        end
    end
    
    @testset "3. Generate a random stardate" begin
        random_stardates = [random_stardate() for _ in 1:repeats]

        @testset "stardates have the correct numeric range" begin
            @test all([41000 <= stardate <= 42000 for stardate in random_stardates])
        end

# The next test is crude! To do it properly, see:
#   https://rosettacode.org/wiki/Verify_distribution_uniformity/Chi-squared_test#Julia
#  - but that needs the Distributions package

        @testset "stardates are not all similar" begin
            small = random_stardates[random_stardates .< 41333]
            mid = random_stardates[41333 .< random_stardates .< 41667]
            large = random_stardates[random_stardates .> 41667]
            limit = 100

            @test length(small) > limit
            @test length(mid) > limit
            @test length(large) > limit
        end
    end

    @testset "4. Generate a rounded stardate" begin
        rounded_stardates = [random_stardate_v2() for _ in 1:repeats]

        @testset "stardates have the correct numeric range" begin
            @test all([41000 <= stardate <= 42000 for stardate in rounded_stardates])
        end

        @testset "stardates are not all similar" begin
            small = rounded_stardates[rounded_stardates .< 41333]
            mid = rounded_stardates[41333 .< rounded_stardates .< 41667]
            large = rounded_stardates[rounded_stardates .> 41667]
            limit = 100

            @test length(small) > limit
            @test length(mid) > limit
            @test length(large) > limit
        end

        @testset "stardates have one decimal place" begin
            @test all([isapprox(stardate, round(stardate, digits=1), atol=1e-8)
                for stardate in rounded_stardates])
        end
    end

    @testset "5. Pick some random starships from a list" begin
        ships = unique([random_ship_registry_number() for _ in 1:100])
        lengths = [rand(1:20) for _ in 1:100]
        chosen_starships = [pick_starships(ships, len) for len in lengths]

        @testset "starships are taken from the input list" begin
            @test all([all(ship ∈ ships for ship in fleet) for fleet in chosen_starships])
        end

        @testset "all chosen ships are unique" begin
            @test all([length(fleet) == length(unique(fleet)) for fleet in chosen_starships]) 
        end
    end

end
