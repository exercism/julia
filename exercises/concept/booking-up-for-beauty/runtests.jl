using Test
using Dates

include("booking-up-for-beauty.jl")

@testset verbose = true "tests" begin

    @testset "1. Parse all-number appointment date" begin
        @test schedule_appointment("7/25/2019 13:45:00") == DateTime(2019, 07, 25, 13, 45, 0)
        @test schedule_appointment("7/8/2021 8:00:00") == DateTime(2021, 07, 08, 8, 00, 0)
    end

    @testset "2. Check if an appointment has already passed" begin
        @test has_passed(now() - Year(1) + Hour(2))
        @test has_passed(now() - Month(8))
        @test has_passed(now() - Day(23))
        @test has_passed(now() - Hour(12))
        @test has_passed(now() - Minute(55))
        @test has_passed(now() - Minute(1))
        @test !has_passed(now() + Minute(1))
        @test !has_passed(now() + Day(19))
        @test !has_passed(now() + Month(10))
        @test !has_passed(now() + Year(2) + Month(3) + Day(6))
    end

    @testset "3. Check if appointment is in the afternoon" begin
        @test !is_afternoon_appointment(DateTime(2019, 6, 17, 8, 15, 0))
        @test !is_afternoon_appointment(DateTime(2019, 2, 23, 11, 59, 59))
        @test is_afternoon_appointment(DateTime(2019, 8, 9, 12, 0, 0))
        @test is_afternoon_appointment(DateTime(2019, 8, 9, 12, 0, 1))
        @test is_afternoon_appointment(DateTime(2019, 9, 1, 17, 59, 59))
        @test !is_afternoon_appointment(DateTime(2019, 9, 1, 18, 0, 0))
        @test !is_afternoon_appointment(DateTime(2019, 9, 1, 23, 59, 59))
    end

    @testset "4. Output an appointment date with textual weekday and month" begin
        @test describe(DateTime(2019, 12, 5, 9, 0, 0)) == "You have an appointment on Thursday, December 5, 2019 at 09:00"
        @test describe(DateTime(2019, 03, 29, 15, 0, 0)) == "You have an appointment on Friday, March 29, 2019 at 15:00"
        @test describe(DateTime(2019, 07, 25, 13, 45, 0)) == "You have an appointment on Thursday, July 25, 2019 at 13:45"
        @test describe(DateTime(2020, 9, 9, 9, 9, 9)) == "You have an appointment on Wednesday, September 9, 2020 at 09:09"
    end

    @testset "5. Return the anniversary date" begin
        @test anniversary_date() == Date(year(now()), 9, 15)
    end
end
