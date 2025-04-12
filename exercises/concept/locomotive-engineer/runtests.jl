using Test 

include("locomotive-engineer.jl")

@testset verbose = true "tests" begin
    @testset "1. test_get_vector_of_wagons" begin
        input_data = [(1,5,2,7,4), (1,5), (1,), (1,9,3), (1,10,6,3,9,8,4,14,24,7)]
        output_data = [[1,5,2,7,4], [1,5], [1], [1,9,3], [1,10,6,3,9,8,4,14,24,7]]

        for (variant, (input, expected)) in enumerate(zip(input_data, output_data))
            @testset "Variation $variant" begin
                @test get_vector_of_wagons(input...) == expected
            end
        end
    end

    @testset "2. test_fix_vector_of_wagons" begin
        input_data = [([2, 5, 1, 7, 4, 12, 6, 3, 13], [3, 17, 6, 15]),
                     ([3, 27, 1, 14, 10, 4, 12, 6, 23, 17, 13, 22, 28, 19], [8, 10, 5, 9, 36, 7, 20]),
                     ([4, 2, 1], [8, 6, 15]), 
                     ([3, 14, 1, 25, 7, 19, 10], [8, 6, 4, 5, 9, 21, 2, 13])
                     ]
        output_data = [[1, 3, 17, 6, 15, 7, 4,  12, 6, 3, 13, 2, 5],
                        [1, 8, 10, 5, 9, 36, 7, 20, 14, 10, 4, 12, 6, 23, 17, 13, 22, 28, 19, 3, 27], 
                        [1, 8, 6, 15, 4, 2], 
                        [1, 8, 6, 4, 5, 9, 21, 2, 13, 25, 7, 19, 10, 3, 14]
                    ]

        for (variant, (input, expected)) in enumerate(zip(input_data, output_data))
            @testset "Variation $variant" begin
                @test fix_vector_of_wagons(input[1], input[2]) == expected
            end
        end
    end
    
    @testset "3. test_add_missing_stops" begin
        input_data = ((Dict("from" => "Berlin", "to" => "Hamburg"), ("stop_1" => "Leipzig", "stop_2" => "Hannover", "stop_3" => "Frankfurt")), 
                        (Dict("from" => "Paris", "to" => "London"), (("stop_1" => "Lille"),)),
                        (Dict("from" => "New York", "to" => "Philadelphia"),()),
                        (Dict("from" => "Gothenburg", "to" => "Copenhagen"), ("stop_1" => "Kungsbacka", "stop_2" => "Varberg", "stop_3" => "Halmstad", "stop_4" => "Angelholm", "stop_5" => "Lund", "stop_6" => "Malmo"))
                        )
        output_data = [Dict("from" => "Berlin", "to" => "Hamburg", "stops" => ["Leipzig", "Hannover", "Frankfurt"]), 
                        Dict("from" => "Paris", "to" => "London", "stops" => ["Lille"]),
                        Dict("from" => "New York", "to" => "Philadelphia", "stops" => []),
                        Dict("from" => "Gothenburg", "to" => "Copenhagen", "stops" => ["Kungsbacka", "Varberg", "Halmstad", "Angelholm", "Lund", "Malmo"])
                    ]

        for (variant, (input, expected)) in enumerate(zip(input_data, output_data))
            @testset "Variation $variant" begin
                @test add_missing_stops(input[1], input[2]...) == expected
            end
        end
    end
    
    
    @testset "4. test_extend_route_information" begin
        input_data = ((Dict("from" => "Berlin", "to" => "Hamburg"), (timeOfArrival = "12:00", precipitation = "10", temperature = "5", caboose = "yes")),
                      (Dict("from" => "Paris", "to" => "London"), (timeOfArrival = "10:30", temperature = "20", length = "15")),
                      (Dict("from" => "Gothenburg", "to" => "Copenhagen"), (precipitation = "1", timeOfArrival = "21:20", temperature = "-6"))
        )
        output_data = [Dict("from" => "Berlin", "to" => "Hamburg", :timeOfArrival => "12:00", :precipitation => "10", :temperature => "5", :caboose => "yes"),
                        Dict("from" => "Paris", "to" => "London", :timeOfArrival => "10:30", :temperature => "20", :length => "15"),
                        Dict("from" => "Gothenburg", "to" => "Copenhagen", :precipitation => "1", :timeOfArrival => "21:20", :temperature => "-6")
                        ]

        for (variant, (input, expected)) in enumerate(zip(input_data, output_data))
            @testset "Variation $variant" begin
                @test extend_route_information(input[1]; input[2]...) == expected
            end
        end
    end

end

