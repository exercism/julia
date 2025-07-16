using Test

include("regular-chatbot.jl")

@testset verbose = true "tests" begin
    
    @testset "1. Check valid command" begin
        # Recognizes whether the command is at the first position
        @test is_valid_command("Chatbot, Do you understand this command?")
        @test !is_valid_command("Hey Chatbot, please tell me what is the weather for tomorrow.")

        # Does not care about UPPER/lower case
        @test is_valid_command("CHATBOT, Is it okay if I shout at you?")
        @test is_valid_command("chatbot, please tell me what is happening here.")
    end

    @testset "2. Remove encrypted emojis" begin
        @test remove_emoji("What was your name? emoji2134 Sorry I forgot about it.") ==
                            "What was your name?  Sorry I forgot about it."

        @test remove_emoji("emoji5321 How about ordering emoji8921 ?") == " How about ordering  ?"
    end

    @testset "3. Check Valid Phone Number" begin
        expected = "Thanks! You can now download me to your phone."
        @test check_phone_number("(+34) 643-876-459") == expected
        @test check_phone_number("(+49) 543-928-190") == expected

        @test check_phone_number("322-787-654") == "Oops, it seems like I can't reach out to 322-787-654"
        @test check_phone_number("4355-67-274") == "Oops, it seems like I can't reach out to 4355-67-274"
    end

    @testset "4. Get website link" begin
        @test getURL("You can check more info on youtube.com") == ["youtube.com",]
        @test getURL("That was from reddit.com and notion.so") == ["reddit.com", "notion.so"]
    end

    @testset "5. Greet the user" begin
        @test nice_to_meet_you("Sanz, Pablo") == "Nice to meet you, Pablo Sanz"
        @test nice_to_meet_you("Stephan, Sandro") == "Nice to meet you, Sandro Stephan"
    end

end
