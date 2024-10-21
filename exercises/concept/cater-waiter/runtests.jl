using Test 

include("cater-waiter.jl")

@testset verbose=true "tests" begin
    @testset "clean ingredients" begin
        test_data = zip(recipes_with_duplicates[1:3:end], recipes_without_duplicates[1:3:end])

        for (item, result) in test_data
            @test clean_ingredients(item[1], item[2]) == (result[2], result[3])
        end
     end

    @testset "check_drinks" begin
        test_data = zip(all_drinks[1:2:end], drink_names[1:2:end])

        for (item, result) in test_data
            @test check_drinks(item[1], item[2]) == result
        end
    end

    @testset "categorize dish" begin
        test_data = zip(sort(recipes_without_duplicates, rev=true)[1:3:end], dishes_categorized[1:3:end])

        for (item, result) in test_data
            @test categorize_dish(item[2], item[3]) == result
        end
    end

    @testset "tag special ingredients" begin
        test_data = zip(dishes_to_special_label[1:3:end], dishes_labeled[1:3:end])

        for (item, result)  in test_data
            @test tag_special_ingredients(item) == result
        end
    end

    @testset "compile ingredients" begin
        test_data = zip(ingredients_only, [VEGAN, VEGETARIAN, PALEO, KETO, OMNIVORE])

        for (item, result) in test_data
            @test compile_ingredients(item) == result
        end
    end

    @testset "separate appetizers" begin
        test_data = zip(dishes_and_appetizers, dishes_cleaned)

        for (item, result) in test_data
            separateappetizers = separate_appetizers(item[1], item[2])
            @test isa(separateappetizers, Vector)
            @test sort(separateappetizers) == sort(result)
        end
    end

    @testset "singleton ingredients" begin
        test_data = zip(dishes_and_overlap, singletons)

        for (item, result) in test_data
            @test singleton_ingredients(item[1], item[2]) == result
        end
    end
end
