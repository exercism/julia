using Test 

include("name-badges.jl")

try
    create_name_badge
catch err
    global create_name_badge = print_name_badge
end

@testset verbose = true "tests" begin
    @testset "1. create_name_badge" begin
        @testset "prints the employee badge with full data" begin
            id = 455
            name = "Mary M. Brown"
            department = "MARKETING"
            expected = "[455] - Mary M. Brown - MARKETING"
            @test create_name_badge(id, name, department) == expected
        end
        
        @testset "uppercases the department" begin
            id = 89
            name = "Jack McGregor"
            department = "Procurement"
            expected = "[89] - Jack McGregor - PROCUREMENT"
            @test create_name_badge(id, name, department) == expected
        end
    end
        
    @testset "2. New employee" begin
        @testset "create the employee badge without id" begin
            id = missing
            name = "Barbara White"
            department = "SECURITY"
            expected = "Barbara White - SECURITY"
            @test create_name_badge(id, name, department) == expected
        end
    end

    @testset "3. prints the owner badge" begin
        @testset "prints the owner badge" begin
            id = 1
            name = "Anna Johnson"
            department = nothing
            expected = "[1] - Anna Johnson - OWNER"
            @test create_name_badge(id, name, department) == expected
        end
    end

    @testset "4. salaries_no_id" begin
        @testset "sums salaries for employees without ID" begin
            ids = [201, 217, missing, 352, 102, missing, 263]
            salaries = [19, 23, 42, 29, 65, 122, 54]
            @test salaries_no_id(ids, salaries) == 164
        end

        @testset "sums salaries but no employees without ID" begin
            ids = [201, 217, 47, 352, 102, 163, 263]
            salaries = [25, 27, 44, 26, 63, 122, 34]
            @test salaries_no_id(ids, salaries) == 0
        end
    end

end
