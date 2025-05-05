using Test

include("land-grab-in-space.jl")

@testset verbose = true "tests" begin

    @testset "1. Custom Types: Coord" begin
        @testset "Coord Type" begin
            coord = Coord(7, 3)
            @test coord.x == 7
            @test coord.y == 3
            @test typeof(coord.x) == UInt16
            @test typeof(coord.y) == UInt16
        end
    end

    @testset "2. Custom Types: Plot" begin
        @testset "Plot Type" begin
            plot = Plot(bottom_left=Coord(1, 2), top_right=Coord(2, 1))
            @test plot.bottom_left == Coord(1, 2)
            @test plot.top_right == Coord(2, 1)
        end
    end

    @testset "3. Is Claim Staked?" begin
        @testset "exists" begin
            plot = Plot(bottom_left=Coord(1, 1), top_right=Coord(2, 3))
            register = Set{Plot}([plot,])
            @test is_claim_staked(plot, register)
        end

        @testset "does not exist" begin
            plot1 = Plot(bottom_left=Coord(1, 1), top_right=Coord(2, 3))
            plot2 = Plot(bottom_left=Coord(3, 0), top_right=Coord(4, 5))
            register = Set{Plot}([plot1,])
            @test !is_claim_staked(plot2, register)
        end
    end

    @testset "4. Stake Claim" begin
        @testset "valid" begin
            plot = Plot(bottom_left=Coord(1, 1), top_right=Coord(2, 3))
            register = Set{Plot}()
            @test stake_claim!(plot, register)
            @test length(register) == 1
        end

        @testset "duplicate" begin
            plot = Plot(bottom_left=Coord(1, 1), top_right=Coord(2, 3))
            register = Set{Plot}([plot,])
            @test !stake_claim!(plot, register)
            @test length(register) == 1
        end
    end

    @testset "5. Longest Side" begin
        @testset "vertical longer" begin
            plot = Plot(bottom_left=Coord(1, 1), top_right=Coord(2, 3))
            @test get_longest_side(plot) == 2
        end

        @testset "horizontal longer" begin
            plot = Plot(bottom_left=Coord(1, 1), top_right=Coord(5, 3))
            @test get_longest_side(plot) == 4
        end
    end

    @testset "6. Get Claim with Longest Side" begin
        @testset "single plot" begin
            longer = Plot(bottom_left=Coord(10, 1), top_right=Coord(20, 2))
            shorter = Plot(bottom_left=Coord(1, 1), top_right=Coord(2, 2))
            register = Set{Plot}([longer, shorter])
            @test get_claim_with_longest_side(register) == Set{Plot}([longer,])
        end

        @testset "multiple plots" begin
            longer1 = Plot(bottom_left=Coord(10, 1), top_right=Coord(20, 2))
            longer2 = Plot(bottom_left=Coord(12, 4), top_right=Coord(22, 4))
            shorter = Plot(bottom_left=Coord(1, 1), top_right=Coord(2, 2))
            register = Set{Plot}([longer1, shorter, longer2])
            @test get_claim_with_longest_side(register) == Set{Plot}([longer1, longer2])
        end
    end
end
