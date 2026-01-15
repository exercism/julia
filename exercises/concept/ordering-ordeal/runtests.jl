using Test

#include("ordering-ordeal.jl")
include(".meta/exemplar.jl")

@testset verbose = true "tests" begin
    
    @testset "1. Sort quantity!" begin
        @testset "Sort permutation" begin
            @test sortquantity!([1, 2, 3, 4, 5]) == [5, 4, 3, 2, 1]
            @test sortquantity!([8, 9, 5, 6]) == [2, 1, 4, 3]
        end

        @testset "Sorted in place" begin
            qty_12345 = [1, 2, 3, 4, 5]
            @test sortquantity!(qty_12345) == [5, 4, 3, 2, 1]
            @test qty_12345 == [5, 4, 3, 2, 1]

            qty_8956 = [8, 9, 5, 6]
            @test sortquantity!(qty_8956) == [2, 1, 4, 3]
            @test qty_8956 == [9, 8, 6, 5]
        end
    end

    @testset "2. Sort customer" begin
        @testset "Sort" begin
            @test sortcustomer(["a", "b", "c", "d", "e"], [5, 4, 3, 2, 1]) == ["e", "d", "c", "b", "a"]
            @test sortcustomer(["a", "b", "c", "d", "e"], sortquantity!([1, 2, 3, 4, 5])) == ["e", "d", "c", "b", "a"]

            @test sortcustomer([1223, 7654, 3232, 8743], [2, 1, 4, 3]) == [7654, 1223, 8743, 3232]
            @test sortcustomer([1223, 7654, 3232, 8743], sortquantity!([8, 9, 5, 6])) == [7654, 1223, 8743, 3232]
        end

        @testset "Not sorted in-place" begin
            cust_abcde = ["a", "b", "c", "d", "e"]
            sortcustomer(cust_abcde, [5, 4, 3, 2, 1])
            @test cust_abcde == ["a", "b", "c", "d", "e"]
            
            cust = [1223, 7654, 3232, 8743]
            sortcustomer([1223, 7654, 3232, 8743], [2, 1, 4, 3])
            @test cust == [1223, 7654, 3232, 8743]
        end
    end

    @testset "3. Production schedule" begin
        @isdefined(production_schedule) && (production_schedule! = production_schedule)
        @test production_schedule!(["a", "b", "c"], [2, 3, 1]) == (["b", "a", "c"], [2, 1, 3])
        @test production_schedule!(["a", "b", "c"], [6, 5, 7]) == (["c", "a", "b"], [2, 3, 1])

        qty_231 = [2, 3, 1]
        cust_abc, invsrtperm_231 = production_schedule!(["a", "b", "c"], qty_231)
        @test (cust_abc[invsrtperm_231], qty_231[invsrtperm_231]) == (["a", "b", "c"], [2, 3, 1])
        
        qty_657 = [6, 5, 7]
        cust_abc, invsrtperm_657 = production_schedule!(["a", "b", "c"], qty_657)
        @test (cust_abc[invsrtperm_657], qty_657[invsrtperm_657]) == (["a", "b", "c"], [6, 5, 7]) 
    end

end
