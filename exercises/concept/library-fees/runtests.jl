using Test

include("library-fees.jl")

@testset "1. Determine if a book was checked out before noon" begin
    @testset "Return true if the given DateTime is before 12:00" begin
        @test  before_noon(DateTime("2020-06-06T11:59:59"))
    end

    @testset "Return false if the given DateTime is after 12:00" begin
        @test !before_noon(DateTime("2021-01-03T12:01:01"))
    end

    @testset "Return false if the given DateTime is exactly 12:00" begin
        @test !before_noon(DateTime("2018-11-17T12:00:00"))
    end
end

@testset "2. Calculate the return Date" begin
    @testset "Add 28 days if the given DateTime is before 12:00" begin
        @test return_date(DateTime("2020-02-14T11:59:59")) == Date("2020-03-13")
    end

    @testset "Add 29 days if the given DateTime is after 12:00" begin
        @test return_date(DateTime("2021-01-03T12:01:01")) == Date("2021-02-01")
    end

    @testset "Add 29 days if the given DateTime is exactly at 12:00" begin
        @test return_date(DateTime("2018-12-01T12:00:00")) == Date("2018-12-30")
    end
end

@testset "3. Determine how late the return of the book was" begin
    @testset "Return 0 days for identical datetimes" begin
        @test days_late(DateTime("2021-02-01T12:00:00"), DateTime("2021-02-01T12:00:00")) == Day(0)
    end

    @testset "Return 0 days for identical dates, but different times" begin
        @test days_late(DateTime("2019-03-11T13:50:00"), DateTime("2019-03-11T12:00:00")) == Day(0)
    end

    @testset "Return 0 when planned return date is later than actual return date" begin
        @test days_late(DateTime("2020-12-03T09:50:00"), DateTime("2020-11-29T16:00:00")) == Day(0)
    end

    @testset "Return date difference in numbers of days when planned return date is earlier than actual return date" begin
        @test days_late(DateTime("2020-06-12T09:50:00"), DateTime("2020-06-21T16:00:00")) == Day(9)
    end
end

@testset "4. Determine if the book was returned on a monday or tuesday" begin
    @testset "Mondays" begin
        @test fee_discount(DateTime("2021-02-01T14:01:00"))
        @test fee_discount(DateTime("2020-03-16T09:23:52"))
        @test fee_discount(DateTime("2019-04-22T15:44:03"))
    end

    @testset "Tuesdays" begin
        @test fee_discount(DateTime("2021-02-02T15:07:00"))
    end

    @testset "Other days" begin
        # Friday
        @test !fee_discount(DateTime("2020-03-14T08:54:51"))

        # Sunday
        @test !fee_discount(DateTime("2019-04-28T11:37:12"))
    end
end

@testset "5. Calculate the late fee" begin
    @testset "Return 0 if the book was returned less than 28 days after a morning checkout" begin
        @test late_fee("2018-11-01T09:00:00", "2018-11-13T14:12:00", 123) == 0
    end
    
    @testset "Return 0 if the book was returned exactly 28 days after a morning checkout" begin
        @test late_fee("2018-11-01T09:00:00", "2018-11-29T14:12:00", 123) == 0
    end
    
    @testset "Return the rate for one day if the book was returned exactly 29 days after a morning checkout" begin
        @test late_fee("2018-11-01T09:00:00", "2018-11-30T14:12:00", 320) == 320
    end
    
    @testset "Return 0 if the book was returned less than 29 days after an afternoon checkout" begin
        @test late_fee("2019-05-01T16:12:00", "2019-05-17T14:32:45", 400) == 0
    end
    
    @testset "Return 0 if the book was returned exactly 29 days after an afternoon checkout" begin
        @test late_fee("2019-05-01T16:12:00", "2019-05-30T14:32:45", 313) == 0
    end
    
    @testset "Return the rate for one day if the book was returned exactly 30 days after an afternoon checkout" begin
        @test late_fee("2019-05-01T16:12:00", "2019-05-31T14:32:45", 234) == 234
    end
    
    @testset "Multiply the number of days late by the rate for one day" begin
        @test late_fee("2021-01-01T08:00:00", "2021-02-13T08:00:00", 111) == 111 * 15
    end
    
    @testset "Late fee is 50% off (rounded down) when the book is returned on a Monday" begin
        @test late_fee("2021-01-01T08:00:00", "2021-02-15T08:00:00", 111) == floor(111 * 17 * 0.5)
    end
end
