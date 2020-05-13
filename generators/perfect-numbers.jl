using Test

using LazyJSON

dir = @__DIR__
jsonfileurl = "https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/perfect-numbers/canonical-data.json"
jsonfilename = "canonical-data.json"
jsonfile = download(jsonfileurl, joinpath(dir,jsonfilename))
outputfile = "parse code.txt"


f = LazyJSON.parse(read(joinpath(dir,jsonfile)))

CODE = """
# canonical data version $(f["version"])
using Test

include("perfect-numbers.jl")

"""
for i in f["cases"]
    global CODE *= """
    @testset \"$(i["description"])\" begin
    """
    for j in i["cases"]
        des = String(j["description"])
        inp = j["input"]["number"]
        exped = j["expected"]
        property = j["property"]

        if i["description"] != "Invalid inputs"
            global CODE *= """

                @testset \"$des\" begin
                    @test is$exped($inp)
                end
            """
        else
            global CODE *= """

                @testset \"$des\" begin
                    @test_throws DomainError isdeficient($inp)
                    @test_throws DomainError isperfect($inp)
                    @test_throws DomainError isabundant($inp)
                end
            """
        end

    end
    global CODE *= """
    end

    """
end

write(joinpath(dir,outputfile), CODE)
