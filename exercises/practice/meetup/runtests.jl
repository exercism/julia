using Test
using Dates

include("meetup.jl")

@testset verbose = true "tests" begin

    @testset "when teenth Monday is the 13th, the first day of the teenth week" begin
        @test meetup(2013, 5, "teenth", "Monday") == Date("2013-05-13", dateformat"y-m-d")
    end

    @testset "when teenth Monday is the 19th, the last day of the teenth week" begin
        @test meetup(2013, 8, "teenth", "Monday") == Date("2013-08-19", dateformat"y-m-d")
    end

    @testset "when teenth Monday is some day in the middle of the teenth week" begin
        @test meetup(2013, 9, "teenth", "Monday") == Date("2013-09-16", dateformat"y-m-d")
    end

    @testset "when teenth Tuesday is the 19th, the last day of the teenth week" begin
        @test meetup(2013, 3, "teenth", "Tuesday") == Date("2013-03-19", dateformat"y-m-d")
    end

    @testset "when teenth Tuesday is some day in the middle of the teenth week" begin
        @test meetup(2013, 4, "teenth", "Tuesday") == Date("2013-04-16", dateformat"y-m-d")
    end

    @testset "when teenth Tuesday is the 13th, the first day of the teenth week" begin
        @test meetup(2013, 8, "teenth", "Tuesday") == Date("2013-08-13", dateformat"y-m-d")
    end

    @testset "when teenth Wednesday is some day in the middle of the teenth week" begin
        @test meetup(2013, 1, "teenth", "Wednesday") == Date("2013-01-16", dateformat"y-m-d")
    end

    @testset "when teenth Wednesday is the 13th, the first day of the teenth week" begin
        @test meetup(2013, 2, "teenth", "Wednesday") == Date("2013-02-13", dateformat"y-m-d")
    end

    @testset "when teenth Wednesday is the 19th, the last day of the teenth week" begin
        @test meetup(2013, 6, "teenth", "Wednesday") == Date("2013-06-19", dateformat"y-m-d")
    end

    @testset "when teenth Thursday is some day in the middle of the teenth week" begin
        @test meetup(2013, 5, "teenth", "Thursday") == Date("2013-05-16", dateformat"y-m-d")
    end

    @testset "when teenth Thursday is the 13th, the first day of the teenth week" begin
        @test meetup(2013, 6, "teenth", "Thursday") == Date("2013-06-13", dateformat"y-m-d")
    end

    @testset "when teenth Thursday is the 19th, the last day of the teenth week" begin
        @test meetup(2013, 9, "teenth", "Thursday") == Date("2013-09-19", dateformat"y-m-d")
    end

    @testset "when teenth Friday is the 19th, the last day of the teenth week" begin
        @test meetup(2013, 4, "teenth", "Friday") == Date("2013-04-19", dateformat"y-m-d")
    end

    @testset "when teenth Friday is some day in the middle of the teenth week" begin
        @test meetup(2013, 8, "teenth", "Friday") == Date("2013-08-16", dateformat"y-m-d")
    end

    @testset "when teenth Friday is the 13th, the first day of the teenth week" begin
        @test meetup(2013, 9, "teenth", "Friday") == Date("2013-09-13", dateformat"y-m-d")
    end

    @testset "when teenth Saturday is some day in the middle of the teenth week" begin
        @test meetup(2013, 2, "teenth", "Saturday") == Date("2013-02-16", dateformat"y-m-d")
    end

    @testset "when teenth Saturday is the 13th, the first day of the teenth week" begin
        @test meetup(2013, 4, "teenth", "Saturday") == Date("2013-04-13", dateformat"y-m-d")
    end

    @testset "when teenth Saturday is the 19th, the last day of the teenth week" begin
        @test meetup(2013, 10, "teenth", "Saturday") == Date("2013-10-19", dateformat"y-m-d")
    end

    @testset "when teenth Sunday is the 19th, the last day of the teenth week" begin
        @test meetup(2013, 5, "teenth", "Sunday") == Date("2013-05-19", dateformat"y-m-d")
    end

    @testset "when teenth Sunday is some day in the middle of the teenth week" begin
        @test meetup(2013, 6, "teenth", "Sunday") == Date("2013-06-16", dateformat"y-m-d")
    end

    @testset "when teenth Sunday is the 13th, the first day of the teenth week" begin
        @test meetup(2013, 10, "teenth", "Sunday") == Date("2013-10-13", dateformat"y-m-d")
    end

    @testset "when first Monday is some day in the middle of the first week" begin
        @test meetup(2013, 3, "first", "Monday") == Date("2013-03-04", dateformat"y-m-d")
    end

    @testset "when first Monday is the 1st, the first day of the first week" begin
        @test meetup(2013, 4, "first", "Monday") == Date("2013-04-01", dateformat"y-m-d")
    end

    @testset "when first Tuesday is the 7th, the last day of the first week" begin
        @test meetup(2013, 5, "first", "Tuesday") == Date("2013-05-07", dateformat"y-m-d")
    end

    @testset "when first Tuesday is some day in the middle of the first week" begin
        @test meetup(2013, 6, "first", "Tuesday") == Date("2013-06-04", dateformat"y-m-d")
    end

    @testset "when first Wednesday is some day in the middle of the first week" begin
        @test meetup(2013, 7, "first", "Wednesday") == Date("2013-07-03", dateformat"y-m-d")
    end

    @testset "when first Wednesday is the 7th, the last day of the first week" begin
        @test meetup(2013, 8, "first", "Wednesday") == Date("2013-08-07", dateformat"y-m-d")
    end

    @testset "when first Thursday is some day in the middle of the first week" begin
        @test meetup(2013, 9, "first", "Thursday") == Date("2013-09-05", dateformat"y-m-d")
    end

    @testset "when first Thursday is another day in the middle of the first week" begin
        @test meetup(2013, 10, "first", "Thursday") == Date("2013-10-03", dateformat"y-m-d")
    end

    @testset "when first Friday is the 1st, the first day of the first week" begin
        @test meetup(2013, 11, "first", "Friday") == Date("2013-11-01", dateformat"y-m-d")
    end

    @testset "when first Friday is some day in the middle of the first week" begin
        @test meetup(2013, 12, "first", "Friday") == Date("2013-12-06", dateformat"y-m-d")
    end

    @testset "when first Saturday is some day in the middle of the first week" begin
        @test meetup(2013, 1, "first", "Saturday") == Date("2013-01-05", dateformat"y-m-d")
    end

    @testset "when first Saturday is another day in the middle of the first week" begin
        @test meetup(2013, 2, "first", "Saturday") == Date("2013-02-02", dateformat"y-m-d")
    end

    @testset "when first Sunday is some day in the middle of the first week" begin
        @test meetup(2013, 3, "first", "Sunday") == Date("2013-03-03", dateformat"y-m-d")
    end

    @testset "when first Sunday is the 7th, the last day of the first week" begin
        @test meetup(2013, 4, "first", "Sunday") == Date("2013-04-07", dateformat"y-m-d")
    end

    @testset "when second Monday is some day in the middle of the second week" begin
        @test meetup(2013, 3, "second", "Monday") == Date("2013-03-11", dateformat"y-m-d")
    end

    @testset "when second Monday is the 8th, the first day of the second week" begin
        @test meetup(2013, 4, "second", "Monday") == Date("2013-04-08", dateformat"y-m-d")
    end

    @testset "when second Tuesday is the 14th, the last day of the second week" begin
        @test meetup(2013, 5, "second", "Tuesday") == Date("2013-05-14", dateformat"y-m-d")
    end

    @testset "when second Tuesday is some day in the middle of the second week" begin
        @test meetup(2013, 6, "second", "Tuesday") == Date("2013-06-11", dateformat"y-m-d")
    end

    @testset "when second Wednesday is some day in the middle of the second week" begin
        @test meetup(2013, 7, "second", "Wednesday") == Date("2013-07-10", dateformat"y-m-d")
    end

    @testset "when second Wednesday is the 14th, the last day of the second week" begin
        @test meetup(2013, 8, "second", "Wednesday") == Date("2013-08-14", dateformat"y-m-d")
    end

    @testset "when second Thursday is some day in the middle of the second week" begin
        @test meetup(2013, 9, "second", "Thursday") == Date("2013-09-12", dateformat"y-m-d")
    end

    @testset "when second Thursday is another day in the middle of the second week" begin
        @test meetup(2013, 10, "second", "Thursday") == Date("2013-10-10", dateformat"y-m-d")
    end

    @testset "when second Friday is the 8th, the first day of the second week" begin
        @test meetup(2013, 11, "second", "Friday") == Date("2013-11-08", dateformat"y-m-d")
    end

    @testset "when second Friday is some day in the middle of the second week" begin
        @test meetup(2013, 12, "second", "Friday") == Date("2013-12-13", dateformat"y-m-d")
    end

    @testset "when second Saturday is some day in the middle of the second week" begin
        @test meetup(2013, 1, "second", "Saturday") == Date("2013-01-12", dateformat"y-m-d")
    end

    @testset "when second Saturday is another day in the middle of the second week" begin
        @test meetup(2013, 2, "second", "Saturday") == Date("2013-02-09", dateformat"y-m-d")
    end

    @testset "when second Sunday is some day in the middle of the second week" begin
        @test meetup(2013, 3, "second", "Sunday") == Date("2013-03-10", dateformat"y-m-d")
    end

    @testset "when second Sunday is the 14th, the last day of the second week" begin
        @test meetup(2013, 4, "second", "Sunday") == Date("2013-04-14", dateformat"y-m-d")
    end

    @testset "when third Monday is some day in the middle of the third week" begin
        @test meetup(2013, 3, "third", "Monday") == Date("2013-03-18", dateformat"y-m-d")
    end

    @testset "when third Monday is the 15th, the first day of the third week" begin
        @test meetup(2013, 4, "third", "Monday") == Date("2013-04-15", dateformat"y-m-d")
    end

    @testset "when third Tuesday is the 21st, the last day of the third week" begin
        @test meetup(2013, 5, "third", "Tuesday") == Date("2013-05-21", dateformat"y-m-d")
    end

    @testset "when third Tuesday is some day in the middle of the third week" begin
        @test meetup(2013, 6, "third", "Tuesday") == Date("2013-06-18", dateformat"y-m-d")
    end

    @testset "when third Wednesday is some day in the middle of the third week" begin
        @test meetup(2013, 7, "third", "Wednesday") == Date("2013-07-17", dateformat"y-m-d")
    end

    @testset "when third Wednesday is the 21st, the last day of the third week" begin
        @test meetup(2013, 8, "third", "Wednesday") == Date("2013-08-21", dateformat"y-m-d")
    end

    @testset "when third Thursday is some day in the middle of the third week" begin
        @test meetup(2013, 9, "third", "Thursday") == Date("2013-09-19", dateformat"y-m-d")
    end

    @testset "when third Thursday is another day in the middle of the third week" begin
        @test meetup(2013, 10, "third", "Thursday") == Date("2013-10-17", dateformat"y-m-d")
    end

    @testset "when third Friday is the 15th, the first day of the third week" begin
        @test meetup(2013, 11, "third", "Friday") == Date("2013-11-15", dateformat"y-m-d")
    end

    @testset "when third Friday is some day in the middle of the third week" begin
        @test meetup(2013, 12, "third", "Friday") == Date("2013-12-20", dateformat"y-m-d")
    end

    @testset "when third Saturday is some day in the middle of the third week" begin
        @test meetup(2013, 1, "third", "Saturday") == Date("2013-01-19", dateformat"y-m-d")
    end

    @testset "when third Saturday is another day in the middle of the third week" begin
        @test meetup(2013, 2, "third", "Saturday") == Date("2013-02-16", dateformat"y-m-d")
    end

    @testset "when third Sunday is some day in the middle of the third week" begin
        @test meetup(2013, 3, "third", "Sunday") == Date("2013-03-17", dateformat"y-m-d")
    end

    @testset "when third Sunday is the 21st, the last day of the third week" begin
        @test meetup(2013, 4, "third", "Sunday") == Date("2013-04-21", dateformat"y-m-d")
    end

    @testset "when fourth Monday is some day in the middle of the fourth week" begin
        @test meetup(2013, 3, "fourth", "Monday") == Date("2013-03-25", dateformat"y-m-d")
    end

    @testset "when fourth Monday is the 22nd, the first day of the fourth week" begin
        @test meetup(2013, 4, "fourth", "Monday") == Date("2013-04-22", dateformat"y-m-d")
    end

    @testset "when fourth Tuesday is the 28th, the last day of the fourth week" begin
        @test meetup(2013, 5, "fourth", "Tuesday") == Date("2013-05-28", dateformat"y-m-d")
    end

    @testset "when fourth Tuesday is some day in the middle of the fourth week" begin
        @test meetup(2013, 6, "fourth", "Tuesday") == Date("2013-06-25", dateformat"y-m-d")
    end

    @testset "when fourth Wednesday is some day in the middle of the fourth week" begin
        @test meetup(2013, 7, "fourth", "Wednesday") == Date("2013-07-24", dateformat"y-m-d")
    end

    @testset "when fourth Wednesday is the 28th, the last day of the fourth week" begin
        @test meetup(2013, 8, "fourth", "Wednesday") == Date("2013-08-28", dateformat"y-m-d")
    end

    @testset "when fourth Thursday is some day in the middle of the fourth week" begin
        @test meetup(2013, 9, "fourth", "Thursday") == Date("2013-09-26", dateformat"y-m-d")
    end

    @testset "when fourth Thursday is another day in the middle of the fourth week" begin
        @test meetup(2013, 10, "fourth", "Thursday") == Date("2013-10-24", dateformat"y-m-d")
    end

    @testset "when fourth Friday is the 22nd, the first day of the fourth week" begin
        @test meetup(2013, 11, "fourth", "Friday") == Date("2013-11-22", dateformat"y-m-d")
    end

    @testset "when fourth Friday is some day in the middle of the fourth week" begin
        @test meetup(2013, 12, "fourth", "Friday") == Date("2013-12-27", dateformat"y-m-d")
    end

    @testset "when fourth Saturday is some day in the middle of the fourth week" begin
        @test meetup(2013, 1, "fourth", "Saturday") == Date("2013-01-26", dateformat"y-m-d")
    end

    @testset "when fourth Saturday is another day in the middle of the fourth week" begin
        @test meetup(2013, 2, "fourth", "Saturday") == Date("2013-02-23", dateformat"y-m-d")
    end

    @testset "when fourth Sunday is some day in the middle of the fourth week" begin
        @test meetup(2013, 3, "fourth", "Sunday") == Date("2013-03-24", dateformat"y-m-d")
    end

    @testset "when fourth Sunday is the 28th, the last day of the fourth week" begin
        @test meetup(2013, 4, "fourth", "Sunday") == Date("2013-04-28", dateformat"y-m-d")
    end

    @testset "last Monday in a month with four Mondays" begin
        @test meetup(2013, 3, "last", "Monday") == Date("2013-03-25", dateformat"y-m-d")
    end

    @testset "last Monday in a month with five Mondays" begin
        @test meetup(2013, 4, "last", "Monday") == Date("2013-04-29", dateformat"y-m-d")
    end

    @testset "last Tuesday in a month with four Tuesdays" begin
        @test meetup(2013, 5, "last", "Tuesday") == Date("2013-05-28", dateformat"y-m-d")
    end

    @testset "last Tuesday in another month with four Tuesdays" begin
        @test meetup(2013, 6, "last", "Tuesday") == Date("2013-06-25", dateformat"y-m-d")
    end

    @testset "last Wednesday in a month with five Wednesdays" begin
        @test meetup(2013, 7, "last", "Wednesday") == Date("2013-07-31", dateformat"y-m-d")
    end

    @testset "last Wednesday in a month with four Wednesdays" begin
        @test meetup(2013, 8, "last", "Wednesday") == Date("2013-08-28", dateformat"y-m-d")
    end

    @testset "last Thursday in a month with four Thursdays" begin
        @test meetup(2013, 9, "last", "Thursday") == Date("2013-09-26", dateformat"y-m-d")
    end

    @testset "last Thursday in a month with five Thursdays" begin
        @test meetup(2013, 10, "last", "Thursday") == Date("2013-10-31", dateformat"y-m-d")
    end

    @testset "last Friday in a month with five Fridays" begin
        @test meetup(2013, 11, "last", "Friday") == Date("2013-11-29", dateformat"y-m-d")
    end

    @testset "last Friday in a month with four Fridays" begin
        @test meetup(2013, 12, "last", "Friday") == Date("2013-12-27", dateformat"y-m-d")
    end

    @testset "last Saturday in a month with four Saturdays" begin
        @test meetup(2013, 1, "last", "Saturday") == Date("2013-01-26", dateformat"y-m-d")
    end

    @testset "last Saturday in another month with four Saturdays" begin
        @test meetup(2013, 2, "last", "Saturday") == Date("2013-02-23", dateformat"y-m-d")
    end

    @testset "last Sunday in a month with five Sundays" begin
        @test meetup(2013, 3, "last", "Sunday") == Date("2013-03-31", dateformat"y-m-d")
    end

    @testset "last Sunday in a month with four Sundays" begin
        @test meetup(2013, 4, "last", "Sunday") == Date("2013-04-28", dateformat"y-m-d")
    end

    @testset "when last Wednesday in February in a leap year is the 29th" begin
        @test meetup(2012, 2, "last", "Wednesday") == Date("2012-02-29", dateformat"y-m-d")
    end

    @testset "last Wednesday in December that is also the last day of the year" begin
        @test meetup(2014, 12, "last", "Wednesday") == Date("2014-12-31", dateformat"y-m-d")
    end

    @testset "when last Sunday in February in a non-leap year is not the 29th" begin
        @test meetup(2015, 2, "last", "Sunday") == Date("2015-02-22", dateformat"y-m-d")
    end

    @testset "when first Friday is the 7th, the last day of the first week" begin
        @test meetup(2012, 12, "first", "Friday") == Date("2012-12-07", dateformat"y-m-d")
    end
end

