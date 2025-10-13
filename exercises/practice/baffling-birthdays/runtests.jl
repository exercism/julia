using Dates, Test

include("baffling-birthdays.jl")

@testset verbose = true "tests" begin
    @testset "Shared birthday" begin
        @testset "one birthdate" begin
            @test !shared_birthday(["2000-01-01"])
        end

        @testset "two birthdates with same year, month, and day" begin
            @test shared_birthday(["2000-01-01", "2000-01-01"])
        end

        @testset "two birthdates with same year and month, but different day" begin
            @test !shared_birthday(["2012-05-09", "2012-05-17"])
        end

        @testset "two birthdates with same month and day, but different year" begin
            @test shared_birthday(["1999-10-23", "1988-10-23"])
        end

        @testset "two birthdates with same year, but different month and day" begin
            @test !shared_birthday(["2007-12-19", "2007-04-27"])
        end

        @testset "two birthdates with different year, month, and day" begin
            @test !shared_birthday(["1997-08-04", "1963-11-23"])
        end

        @testset "multiple birthdates without shared birthday" begin
            birthdates = [
                "1966-07-29",
                "1977-02-12",
                "2001-12-25",
                "1980-11-10"
            ]
            @test !shared_birthday(birthdates)
        end

        @testset "multiple birthdates with one shared birthday" begin
            birthdates = [
                "1966-07-29",
                "1977-02-12",
                "2001-07-29",
                "1980-11-10"
            ]
            @test shared_birthday(birthdates)
       end

        @testset "multiple birthdates with more than one shared birthday" begin
            birthdates = [
                "1966-07-29",
                "1977-02-12",
                "2001-12-25",
                "1980-07-29",
                "2019-02-12"
            ]
            @test shared_birthday(birthdates)
        end
    end
    
    @testset "Random birthdates" begin
        @testset "Random birthdates generated requested number of birthdates" begin
            @test all(length(random_birthdates(groupsize)) == groupsize for groupsize in 1:20)
        end

        @testset "Random birthdates are not in leap years" begin
            @test all(!isleapyear, random_birthdates(100))
        end

        @testset "Random birthdates appear random" begin
            birthdates = random_birthdates(500)
            months = month.(birthdates) |> unique
            days = day.(birthdates) |> unique

            # We may want to refine these thresholds!
            @test length(months) ≥ 11
            @test length(days) ≥ 29
        end
    end

    @testset "Estimated probability of at least one shared birthday" begin
        # C# uses atol=1.0 for all cases, so this presumably works most of the time
        # Elixir is more sophisticated: 
        #   https://github.com/exercism/elixir/blob/main/exercises/practice/baffling-birthdays/test/baffling_birthdays_test.exs

        # this should be very, very close to zero!
        @testset "for one person" begin
            @test isapprox(estimate_probability_of_shared_birthday(1), 0.0, atol = 0.1)
        end

        @testset "among ten people" begin
            @test isapprox(estimate_probability_of_shared_birthday(10), 0.11694818, atol=0.01)
        end

        # this mid-value is noisier, so the atol is increased
        @testset "among twenty-three people" begin
            @test isapprox(estimate_probability_of_shared_birthday(23), 0.50729723, atol=0.03)
        end

        @testset "among seventy people" begin
            @test isapprox(estimate_probability_of_shared_birthday(70), 0.99915958, atol=0.01)
        end
    end
end
