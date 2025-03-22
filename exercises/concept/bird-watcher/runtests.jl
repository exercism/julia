using Test

include("bird-watcher.jl")

@testset verbose = true "tests" begin

    @testset "1. Check how many birds visited today" begin
        @testset "Today for disappointing day" begin
            birds_per_day = [0, 0, 1, 0, 0, 1, 0]
            @test today(birds_per_day) == 0
        end

        @testset "Today for busy day" begin
            birds_per_day = [8, 8, 9, 5, 4, 7, 10]
            today(birds_per_day) == 10
        end
    end

    @testset "2. Increment today's count" begin
        @testset "Increment todays count with no previous visits" begin
            birds_per_day = [0, 0, 0, 4, 2, 3, 0]
            @test increment_todays_count(birds_per_day) == [0, 0, 0, 4, 2, 3, 1]
        end

        @testset "Increment todays count with multiple previous visits" begin
            birds_per_day = [8, 8, 9, 2, 1, 6, 4]
            @test increment_todays_count(birds_per_day) == [8, 8, 9, 2, 1, 6, 5]
        end
    end

    @testset "3. Check if there was a day with no visiting birds" begin
        @testset "With day without birds" begin
            birds_per_day = [5, 5, 4, 0, 7, 6, 7]
            @test has_day_without_birds(birds_per_day) == true
        end

        @testset "With no day without birds" begin
            birds_per_day = [4, 5, 9, 10, 9, 4, 3]
            @test has_day_without_birds(birds_per_day) == false
        end
    end

    @testset "4. Calculate the number of visiting birds for the first number of days" begin
        @testset "Count for first three days of disappointing week" begin
            birds_per_day = [0, 0, 1, 0, 0, 1, 0]
            @test count_for_first_days(birds_per_day, 3) == 1
        end

        @testset "Count for first six days of busy week" begin
            birds_per_day = [5, 9, 12, 6, 8, 8, 17]
            @test count_for_first_days(birds_per_day, 6) == 48
        end
    end

    @testset "5. Calculate the number of busy days" begin
        @testset "Busy days for disappointing week" begin
            birds_per_day = [1, 1, 1, 0, 0, 0, 0]
            @test busy_days(birds_per_day) == 0
        end

        @testset "Busy days for busy week" begin
            birds_per_day = [4, 9, 5, 7, 8, 8, 2]
            @test busy_days(birds_per_day) == 5
        end
    end

    @testset "6. Calculate averages by day of the week" begin
        @testset "Two disappointing weeks" begin
            week1 = [1, 1, 1, 0, 0, 0, 0]
            week2 = [0, 0, 1, 0, 0, 1, 0]
            expected = [0.5, 0.5, 1.0, 0.0, 0.0, 0.5, 0.0]
            matches = isapprox.(average_per_day(week1, week2), expected, atol=1e-8)
            @test all(matches .== true)
        end

        @testset "Two busy weeka" begin
            week1 = [5, 9, 12, 6, 8, 8, 17]
            week2 = [4, 9, 5, 7, 8, 8, 2]
            expected = [4.5, 9.0, 8.5, 6.5, 8.0, 8.0, 9.5]
            matches = isapprox.(average_per_day(week1, week2), expected, atol=1e-8)
            @test all(matches .== true)
        end
    end

end

