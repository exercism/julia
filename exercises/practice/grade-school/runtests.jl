using Test

include("grade-school.jl")

Student = NamedTuple{(:name, :grade), Tuple{String, Int}}

@testset verbose = true "tests" begin
     @testset "Roster is empty when no student is added" begin
        school = new_school()
        @test roster(school) == []
    end
    
    @testset "Add a student" begin
        school = new_school()
        students = [
            Student(("Aimee", 2))
            ]
        @test add!(students, school) == [true]
    end
    
    @testset "Student is added to the roster" begin
        school = new_school()
        students = [
            Student(("Aimee", 2))
            ]
        add!(students, school)
        @test roster(school) == ["Aimee"]
    end
    
    @testset "Adding multiple students in the same grade in the roster" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("Paul", 2))
        ]
        @test add!(students, school) == [true, true, true]
    end
    
    @testset "Multiple students in the same grade are added to the roster" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("Paul", 2))
        ]
        add!(students, school)
        @test roster(school) == ["Blair", "James", "Paul"]
    end
    
    @testset "Cannot add student to same grade in the roster more than once" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("James", 2)),
            Student(("Paul", 2))
        ]
        @test add!(students, school) == [true, true, false, true]
    end
    
    @testset "A student can't be in two different grades" begin
        school = new_school()
        students = [
            Student(("Aimee", 2)),
            Student(("Aimee", 1))
        ]
        add!(students, school)      
        @test grade(2, school) == ["Aimee"]
        @test grade(1, school) == []
    end
    
    @testset "A student can only be added to the same grade in the roster once" begin
        school = new_school()
        students = [
            Student(("Aimee", 2)),
            Student(("Aimee", 2))
        ]
        add!(students, school)
        @test roster(school) == ["Aimee"]
    end
    
    @testset "Student not added to same grade in the roster more than once" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("James", 2)),
            Student(("Paul", 2))
        ]
        add!(students, school)
        @test roster(school) == ["Blair", "James", "Paul"]
    end
    
    @testset "Students in multiple grades are added to the roster" begin
        school = new_school()
        students = [
            Student(("Chelsea", 3)),
            Student(("Logan", 7))
        ]
        add!(students, school)
        @test roster(school) == ["Chelsea", "Logan"]
    end
    
    @testset "Cannot add same student to multiple grades in the roster" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("James", 3)),
            Student(("Paul", 3))
        ]
        
        @test add!(students, school) == [true, true, false, true]
    end
    
    @testset "A student cannot be added to more than one grade in the sorted roster" begin
        school = new_school()
        students = [
            Student(("Aimee", 2)),
            Student(("Aimee", 1))
        ]
        add!(students, school)
        @test roster(school) == ["Aimee"]
    end
    
    @testset "Student not added to multiple grades in the roster" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("James", 3)),
            Student(("Paul", 3))
        ]
        add!(students, school)
        @test roster(school) == ["Blair", "James", "Paul"]
    end
    
    @testset "Students are sorted by grades in the roster" begin
        school = new_school()
        students = [
            Student(("Jim", 3)),
            Student(("Peter", 2)),
            Student(("Anna", 1))
        ]
        add!(students, school)
        @test roster(school) == ["Anna", "Peter", "Jim"]
    end
    
    @testset "Students are sorted by name in the roster" begin
        school = new_school()
        students = [
            Student(("Peter", 2)),
            Student(("Zoe", 2)),
            Student(("Alex", 2))
        ]
        add!(students, school)
        @test roster(school) == ["Alex", "Peter", "Zoe"]
    end
    
    @testset "Students are sorted by grades and then by name in the roster" begin
        school = new_school()
        students = [
            Student(("Peter", 2)),
            Student(("Anna", 1)),
            Student(("Barb", 1)),
            Student(("Zoe", 2)),
            Student(("Alex", 2)),
            Student(("Jim", 3)),
            Student(("Charlie", 1))
        ]
        add!(students, school)
        @test roster(school) == ["Anna", "Barb", "Charlie", "Alex", "Peter", "Zoe", "Jim"]
    end
    
    @testset "Grade is empty if no students in the roster" begin
        school = new_school()
        @test grade(1, school) == []
    end
    
    @testset "Grade is empty if no students in that grade" begin
        school = new_school()
        students = [
            Student(("Peter", 2)),
            Student(("Zoe", 2)),
            Student(("Alex", 2)),
            Student(("Jim", 3))
        ]
        add!(students, school)
        @test grade(1, school) == []
    end
    
    @testset "Student not added to same grade more than once" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("James", 2)),
            Student(("Paul", 2))
        ]
        add!(students, school)
        @test grade(2, school) == ["Blair", "James", "Paul"]
    end
    
    @testset "Student not added to multiple grades" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("James", 3)),
            Student(("Paul", 3))
        ]
        add!(students, school)
        @test grade(2, school) == ["Blair", "James"]
    end
    
    @testset "Student not added to other grade for multiple grades" begin
        school = new_school()
        students = [
            Student(("Blair", 2)),
            Student(("James", 2)),
            Student(("James", 3)),
            Student(("Paul", 3))
        ]
        add!(students, school)
        @test grade(3, school) == ["Paul"]
    end
    
    @testset "Students are sorted by name in a grade" begin
        school = new_school()
        students = [
            Student(("Franklin", 5)),
            Student(("Bradley", 5)),
            Student(("Jeff", 1))
        ]
        add!(students, school)
        @test grade(5, school) == ["Bradley", "Franklin"]
    end
    
end