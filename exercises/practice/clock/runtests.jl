using Dates, Test

include("clock.jl")

@testset "Create a new clock with an initial time" begin
    # on the hour
    @test Clock(8, 0) == Clock(8, 0)

    # past the hour
    @test Clock(11, 9) == Clock(11, 9)

    # midnight is zero hours
    @test Clock(24, 0) == Clock(0, 0)

    # hour rolls over
    @test Clock(25, 0) == Clock(1, 0)

    # hour rolls over continuously
    @test Clock(100, 0) == Clock(4, 0)

    # sixty minutes is next hour
    @test Clock(1, 60) == Clock(2, 0)

    # minutes roll over
    @test Clock(0, 160) == Clock(2, 40)

    # minutes roll over continuously
    @test Clock(0, 1723) == Clock(4, 43)

    # hour and minutes roll over
    @test Clock(25, 160) == Clock(3, 40)

    # hour and minutes roll over continuously
    @test Clock(201, 3001) == Clock(11, 1)

    # hour and minutes roll over to exactly midnight
    @test Clock(72, 8640) == Clock(0, 0)

    # negative hour
    @test Clock(-1, 15) == Clock(23, 15)

    # negative hour rolls over
    @test Clock(-25, 0) == Clock(23, 0)

    # negative hour rolls over continuously
    @test Clock(-91, 0) == Clock(5, 0)

    # negative minutes
    @test Clock(1, -40) == Clock(0, 20)

    # negative minutes roll over
    @test Clock(1, -160) == Clock(22, 20)

    # negative minutes roll over continuously
    @test Clock(1, -4820) == Clock(16, 40)

    # negative sixty minutes is previous hour
    @test Clock(2, -60) == Clock(1, 0)

    # negative hour and minutes both roll over
    @test Clock(-25, -160) == Clock(20, 20)

    # negative hour and minutes both roll over continuously
    @test Clock(-121, -5810) == Clock(22, 10)
end

@testset "Add minutes" begin
    # add minutes
    @test Clock(10, 0) + Dates.Minute(3) == Clock(10, 3)

    # add no minutes
    @test Clock(6, 41) + Dates.Minute(0) == Clock(6, 41)

    # add to next hour
    @test Clock(0, 45) + Dates.Minute(40) == Clock(1, 25)

    # add more than one hour
    @test Clock(10, 0) + Dates.Minute(61) == Clock(11, 1)

    # add more than two hours with carry
    @test Clock(0, 45) + Dates.Minute(160) == Clock(3, 25)

    # add across midnight
    @test Clock(23, 59) + Dates.Minute(2) == Clock(0, 1)

    # add more than one day (1500 min = 25 hrs)
    @test Clock(5, 32) + Dates.Minute(1500) == Clock(6, 32)

    # add more than two days
    @test Clock(1, 1) + Dates.Minute(3500) == Clock(11, 21)
end

@testset "Subtract minutes" begin
    # subtract minutes
    @test Clock(10, 3) - Dates.Minute(3) == Clock(10, 0)

    # subtract to previous hour
    @test Clock(10, 3) - Dates.Minute(30) == Clock(9, 33)

    # subtract more than an hour
    @test Clock(10, 3) - Dates.Minute(70) == Clock(8, 53)

    # subtract across midnight
    @test Clock(0, 3) - Dates.Minute(4) == Clock(23, 59)

    # subtract more than two hours
    @test Clock(0, 0) - Dates.Minute(160) == Clock(21, 20)

    # subtract more than two hours with borrow
    @test Clock(6, 15) - Dates.Minute(160) == Clock(3, 35)

    # subtract more than one day (1500 min = 25 hrs)
    @test Clock(5, 32) - Dates.Minute(1500) == Clock(4, 32)

    # subtract more than two days
    @test Clock(2, 20) - Dates.Minute(3000) == Clock(0, 20)
end

@testset "Compare two clocks for equality" begin
    # clocks with same time
    @test Clock(15, 37) == Clock(15, 37)

    # clocks a minute apart
    @test Clock(15, 36) != Clock(15, 37)

    # clocks an hour apart
    @test Clock(14, 37) != Clock(15, 37)

    # clocks with hour overflow
    @test Clock(10, 37) == Clock(34, 37)

    # clocks with hour overflow by several days
    @test Clock(3, 11) == Clock(99, 11)

    # clocks with negative hour
    @test Clock(22, 40) == Clock(-2, 40)

    # clocks with negative hour that wraps
    @test Clock(17, 3) == Clock(-31, 3)

    # clocks with negative hour that wraps multiple times
    @test Clock(13, 49) == Clock(-83, 49)

    # clocks with minute overflow
    @test Clock(0, 1) == Clock(0, 1441)

    # clocks with minute overflow by several days
    @test Clock(2, 2) == Clock(2, 4322)

    # clocks with negative minute
    @test Clock(2, 40) == Clock(3, -20)

    # clocks with negative minute that wraps
    @test Clock(4, 10) == Clock(5, -1490)

    # clocks with negative minute that wraps multiple times
    @test Clock(6, 15) == Clock(6, -4305)

    # clocks with negative hours and minutes
    @test Clock(7, 32) == Clock(-12, -268)

    # clocks with negative hours and minutes that wrap
    @test Clock(18, 7) == Clock(-54, -11513)

    # full clock and zeroed clock
    @test Clock(24, 0) == Clock(0, 0)
end

@testset "displaying clocks" begin
    @test sprint(show, Clock(8, 0)) == "\"08:00\""
    @test sprint(show, Clock(11, 9)) == "\"11:09\""
    @test sprint(show, Clock(24, 0)) == "\"00:00\""
    @test sprint(show, Clock(25, 0)) == "\"01:00\""
    @test sprint(show, Clock(100, 0)) == "\"04:00\""
    @test sprint(show, Clock(1, 60)) == "\"02:00\""
    @test sprint(show, Clock(0, 160)) == "\"02:40\""
    @test sprint(show, Clock(0, 1723)) == "\"04:43\""
    @test sprint(show, Clock(25, 160)) == "\"03:40\""
    @test sprint(show, Clock(201, 3001)) == "\"11:01\""
    @test sprint(show, Clock(72, 8640)) == "\"00:00\""
    @test sprint(show, Clock(-1, 15)) == "\"23:15\""
    @test sprint(show, Clock(-25, 0)) == "\"23:00\""
    @test sprint(show, Clock(-91, 0)) == "\"05:00\""
    @test sprint(show, Clock(1, -40)) == "\"00:20\""
    @test sprint(show, Clock(1, -160)) == "\"22:20\""
    @test sprint(show, Clock(1, -4820)) == "\"16:40\""
    @test sprint(show, Clock(2, -60)) == "\"01:00\""
    @test sprint(show, Clock(-25, -160)) == "\"20:20\""
    @test sprint(show, Clock(-121, -5810)) == "\"22:10\""
end
