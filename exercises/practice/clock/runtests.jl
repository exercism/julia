# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/clock/canonical-data.json
# File last updated on 2026-10-25

using Test
using Dates

include("clock.jl")

@testset verbose = true "tests" begin
    @testset "Create a new clock with an initial time" begin
        @testset "on the hour" begin
            @test Clock(8, 0) == Clock(8, 0)
            @test sprint(show, Clock(8, 0)) == "\"08:00\""
        end

        @testset "past the hour" begin
            @test Clock(11, 9) == Clock(11, 9)
            @test sprint(show, Clock(11, 9)) == "\"11:09\""
        end

        @testset "midnight is zero hours" begin
            @test Clock(24, 0) == Clock(0, 0)
            @test sprint(show, Clock(24, 0)) == "\"00:00\""
        end

        @testset "hour rolls over" begin
            @test Clock(25, 0) == Clock(1, 0)
            @test sprint(show, Clock(25, 0)) == "\"01:00\""
        end

        @testset "hour rolls over continuously" begin
            @test Clock(100, 0) == Clock(4, 0)
            @test sprint(show, Clock(100, 0)) == "\"04:00\""
        end

        @testset "sixty minutes is next hour" begin
            @test Clock(1, 60) == Clock(2, 0)
            @test sprint(show, Clock(1, 60)) == "\"02:00\""
        end

        @testset "minutes roll over" begin
            @test Clock(0, 160) == Clock(2, 40)
            @test sprint(show, Clock(0, 160)) == "\"02:40\""
        end

        @testset "minutes roll over continuously" begin
            @test Clock(0, 1723) == Clock(4, 43)
            @test sprint(show, Clock(0, 1723)) == "\"04:43\""
        end

        @testset "hour and minutes roll over" begin
            @test Clock(25, 160) == Clock(3, 40)
            @test sprint(show, Clock(25, 160)) == "\"03:40\""
        end

        @testset "hour and minutes roll over continuously" begin
            @test Clock(201, 3001) == Clock(11, 1)
            @test sprint(show, Clock(201, 3001)) == "\"11:01\""
        end

        @testset "hour and minutes roll over to exactly midnight" begin
            @test Clock(72, 8640) == Clock(0, 0)
            @test sprint(show, Clock(72, 8640)) == "\"00:00\""
        end

        @testset "negative hour" begin
            @test Clock(-1, 15) == Clock(23, 15)
            @test sprint(show, Clock(-1, 15)) == "\"23:15\""
        end

        @testset "negative hour rolls over" begin
            @test Clock(-25, 0) == Clock(23, 0)
            @test sprint(show, Clock(-25, 0)) == "\"23:00\""
        end

        @testset "negative hour rolls over continuously" begin
            @test Clock(-91, 0) == Clock(5, 0)
            @test sprint(show, Clock(-91, 0)) == "\"05:00\""
        end

        @testset "negative minutes" begin
            @test Clock(1, -40) == Clock(0, 20)
            @test sprint(show, Clock(1, -40)) == "\"00:20\""
        end

        @testset "negative minutes roll over" begin
            @test Clock(1, -160) == Clock(22, 20)
            @test sprint(show, Clock(1, -160)) == "\"22:20\""
        end

        @testset "negative minutes roll over continuously" begin
            @test Clock(1, -4820) == Clock(16, 40)
            @test sprint(show, Clock(1, -4820)) == "\"16:40\""
        end

        @testset "negative sixty minutes is previous hour" begin
            @test Clock(2, -60) == Clock(1, 0)
            @test sprint(show, Clock(2, -60)) == "\"01:00\""
        end

        @testset "negative hour and minutes both roll over" begin
            @test Clock(-25, -160) == Clock(20, 20)
            @test sprint(show, Clock(-25, -160)) == "\"20:20\""
        end

        @testset "negative hour and minutes both roll over continuously" begin
            @test Clock(-121, -5810) == Clock(22, 10)
            @test sprint(show, Clock(-121, -5810)) == "\"22:10\""
        end
    end

    @testset "Add minutes" begin
        @testset "add minutes" begin
            @test Clock(10, 0) + Dates.Minute(3) == Clock(10, 3)
        end

        @testset "add no minutes" begin
            @test Clock(6, 41) + Dates.Minute(0) == Clock(6, 41)
        end

        @testset "add to next hour" begin
            @test Clock(0, 45) + Dates.Minute(40) == Clock(1, 25)
        end

        @testset "add more than one hour" begin
            @test Clock(10, 0) + Dates.Minute(61) == Clock(11, 1)
        end

        @testset "add more than two hours with carry" begin
            @test Clock(0, 45) + Dates.Minute(160) == Clock(3, 25)
        end

        @testset "add across midnight" begin
            @test Clock(23, 59) + Dates.Minute(2) == Clock(0, 1)
        end

        @testset "add more than one day (1500 min = 25 hrs)" begin
            @test Clock(5, 32) + Dates.Minute(1500) == Clock(6, 32)
        end

        @testset "add more than two days" begin
            @test Clock(1, 1) + Dates.Minute(3500) == Clock(11, 21)
        end
    end

    @testset "Subtract minutes" begin
        @testset "subtract minutes" begin
            @test Clock(10, 3) - Dates.Minute(3) == Clock(10, 0)
        end

        @testset "subtract to previous hour" begin
            @test Clock(10, 3) - Dates.Minute(30) == Clock(9, 33)
        end

        @testset "subtract more than an hour" begin
            @test Clock(10, 3) - Dates.Minute(70) == Clock(8, 53)
        end

        @testset "subtract across midnight" begin
            @test Clock(0, 3) - Dates.Minute(4) == Clock(23, 59)
        end

        @testset "subtract more than two hours" begin
            @test Clock(0, 0) - Dates.Minute(160) == Clock(21, 20)
        end

        @testset "subtract more than two hours with borrow" begin
            @test Clock(6, 15) - Dates.Minute(160) == Clock(3, 35)
        end

        @testset "subtract more than one day (1500 min = 25 hrs)" begin
            @test Clock(5, 32) - Dates.Minute(1500) == Clock(4, 32)
        end

        @testset "subtract more than two days" begin
            @test Clock(2, 20) - Dates.Minute(3000) == Clock(0, 20)
        end
    end

    @testset "Compare two clocks for equality" begin
        @testset "clocks with same time" begin
            @test Clock(15, 37) == Clock(15, 37)
        end

        @testset "clocks a minute apart" begin
            @test Clock(15, 36) != Clock(15, 37)
        end

        @testset "clocks an hour apart" begin
            @test Clock(14, 37) != Clock(15, 37)
        end

        @testset "clocks with hour overflow" begin
            @test Clock(10, 37) == Clock(34, 37)
        end

        @testset "clocks with hour overflow by several days" begin
            @test Clock(3, 11) == Clock(99, 11)
        end

        @testset "clocks with negative hour" begin
            @test Clock(22, 40) == Clock(-2, 40)
        end

        @testset "clocks with negative hour that wraps" begin
            @test Clock(17, 3) == Clock(-31, 3)
        end

        @testset "clocks with negative hour that wraps multiple times" begin
            @test Clock(13, 49) == Clock(-83, 49)
        end

        @testset "clocks with minute overflow" begin
            @test Clock(0, 1) == Clock(0, 1441)
        end

        @testset "clocks with minute overflow by several days" begin
            @test Clock(2, 2) == Clock(2, 4322)
        end

        @testset "clocks with negative minute" begin
            @test Clock(2, 40) == Clock(3, -20)
        end

        @testset "clocks with negative minute that wraps" begin
            @test Clock(4, 10) == Clock(5, -1490)
        end

        @testset "clocks with negative minute that wraps multiple times" begin
            @test Clock(6, 15) == Clock(6, -4305)
        end

        @testset "clocks with negative hours and minutes" begin
            @test Clock(7, 32) == Clock(-12, -268)
        end

        @testset "clocks with negative hours and minutes that wrap" begin
            @test Clock(18, 7) == Clock(-54, -11513)
        end

        @testset "full clock and zeroed clock" begin
            @test Clock(24, 0) == Clock(0, 0)
        end
    end
end
