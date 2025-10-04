using Test

include("swift-scheduling.jl")

@testset verbose = true "tests" begin
    @testset "NOW translates to two hours later" begin
        @test delivery_date("2012-02-13T09:00:00", "NOW") ==  "2012-02-13T11:00:00"
    end

    @testset "ASAP before one in the afternoon translates to today at five in the afternoon" begin
        @test delivery_date("1999-06-03T09:45:00", "ASAP") ==  "1999-06-03T17:00:00"
    end

    @testset "ASAP at one in the afternoon translates to tomorrow at one in the afternoon" begin
        @test delivery_date("2008-12-21T13:00:00", "ASAP") ==  "2008-12-22T13:00:00"
    end

    @testset "ASAP after one in the afternoon translates to tomorrow at one in the afternoon" begin
        @test delivery_date("2008-12-21T14:50:00", "ASAP") ==  "2008-12-22T13:00:00"
    end

    @testset "EOW on Monday translates to Friday at five in the afternoon" begin
        @test delivery_date("2025-02-03T16:00:00", "EOW") ==  "2025-02-07T17:00:00"
    end

    @testset "EOW on Tuesday translates to Friday at five in the afternoon" begin
        @test delivery_date("1997-04-29T10:50:00", "EOW") ==  "1997-05-02T17:00:00"
    end

    @testset "EOW on Wednesday translates to Friday at five in the afternoon" begin
        @test delivery_date("2005-09-14T11:00:00", "EOW") ==  "2005-09-16T17:00:00"
    end

    @testset "EOW on Thursday translates to Sunday at eight in the evening" begin
        @test delivery_date("2011-05-19T08:30:00", "EOW") ==  "2011-05-22T20:00:00"
    end

    @testset "EOW on Friday translates to Sunday at eight in the evening" begin
        @test delivery_date("2022-08-05T14:00:00", "EOW") ==  "2022-08-07T20:00:00"
    end

    @testset "EOW translates to leap day" begin
        @test delivery_date("2008-02-25T10:30:00", "EOW") ==  "2008-02-29T17:00:00"
    end

    @testset "2M before the second month of this year translates to the first workday of the second month of this year" begin
        @test delivery_date("2007-01-02T14:15:00", "2M") ==  "2007-02-01T08:00:00"
    end

    @testset "11M in the eleventh month translates to the first workday of the eleventh month of next year" begin
        @test delivery_date("2013-11-21T15:30:00", "11M") ==  "2014-11-03T08:00:00"
    end

    @testset "4M in the ninth month translates to the first workday of the fourth month of next year" begin
        @test delivery_date("2019-11-18T15:15:00", "4M") ==  "2020-04-01T08:00:00"
    end

    @testset "Q1 in the first quarter translates to the last workday of the first quarter of this year" begin
        @test delivery_date("2003-01-01T10:45:00", "Q1") ==  "2003-03-31T08:00:00"
    end

    @testset "Q4 in the second quarter translates to the last workday of the fourth quarter of this year" begin
        @test delivery_date("2001-04-09T09:00:00", "Q4") ==  "2001-12-31T08:00:00"
    end

    @testset "Q3 in the fourth quarter translates to the last workday of the third quarter of next year" begin
        @test delivery_date("2022-10-06T11:00:00", "Q3") ==  "2023-09-29T08:00:00"
    end

end
