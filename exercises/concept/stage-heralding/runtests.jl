using Test

include("card-generator.jl")

@testset "Speedrunning 101" begin
    @test generate_card("»Speedrunning 101« – Sasha Duda Krall (they/them), from GDQU. Start: 13:00, Q&A: 13:20, End: 13:30") == """
        - Our next speaker is Sasha Duda Krall, from GDQU
        - Their talk is called »Speedrunning 101«
        - They will answer your questions in the Q&A session at the end of the talk, starting at 13:20
        
        13:00 - 13:20 - 13:30
        """
end

@testset "How I learned to say Farewell" begin
    @test generate_card("»How I learned to say Farewell« – Madeline (she/her). Start: 13:40, Q&A: 14:00, End: 14:05") == """
        - Our next speaker is Madeline
        - Her talk is called »How I learned to say Farewell«
        - She will answer your questions in the Q&A session at the end of the talk, starting at 14:00
        
        13:40 - 14:00 - 14:05
        """
end

@testset "How To Find a Good Title For Your Conference Talk" begin
    @test generate_card("»How To Find a Good Title For Your Conference Talk« – Vítězslav Kruse (he/him). Start: 14:15, End: 14:40") == """
        - Our next speaker is Vítězslav Kruse
        - His talk is called »How To Find a Good Title For Your Conference Talk«
        - There will not be a Q&A session
        
        14:15 - NO Q&A - 14:40
        """
end

@testset "Why Emoji Matter❣" begin
    @test generate_card("»Why Emoji Matter❣« – Ash van Amelsvoort, from the University of 🧬🧪⚛. Start: 14:50, Q&A: 15:05, End: 15:10") == """
        - Our next speaker is Ash van Amelsvoort, from the University of 🧬🧪⚛
        - Ash van Amelsvoort's talk is called »Why Emoji Matter❣«
        - Ash van Amelsvoort will answer your questions in the Q&A session at the end of the talk, starting at 15:05
        
        14:50 - 15:05 - 15:10
        """
end

@testset "»Can dogs look up?" begin
    @test generate_card("»Can dogs look up?« – Kira \"k1ralli\" Sørensen. Start: 20:50, Q&A: 21:05, End: 21:10") == """
        - Our next speaker is Kira "k1ralli" Sørensen
        - Kira "k1ralli" Sørensen's talk is called »Can dogs look up?«
        - Kira "k1ralli" Sørensen will answer your questions in the Q&A session at the end of the talk, starting at 21:05
        
        20:50 - 21:05 - 21:10
        """
end

@testset "SQL Injection 201" begin
    @test generate_card("»SQL Injection 201« – Robert'); DROP TABLE Students; --. Start: 21:15, Q&A: 21:40, End: 21:45") == """
        - Our next speaker is Robert'); DROP TABLE Students; --
        - Robert'); DROP TABLE Students; --'s talk is called »SQL Injection 201«
        - Robert'); DROP TABLE Students; -- will answer your questions in the Q&A session at the end of the talk, starting at 21:40
        
        21:15 - 21:40 - 21:45
        """
end
