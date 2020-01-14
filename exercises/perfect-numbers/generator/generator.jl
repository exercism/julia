# canonical version = 1.3.0
using Test

using LazyJSON

j = LazyJSON.value(String(read("generator\\canonical-data.json")))
CODE = ""
for i in j["cases"]
    for j in i["cases"]
        des = String(j["description"])
        inp = j["input"]["number"]

        i["description"] == "Invalid inputs" ? exped = j["expected"]["error"] : exped = j["expected"]
        global CODE *= """
        @testset \"$des\" begin
           @test classify($inp) == \"$exped\"
        end
        """

    end
end

write("generator\\copy and pase code from here.txt", CODE)
