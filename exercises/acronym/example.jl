function acronym(str::AbstractString)
  
   string = ""

  for chr in split(str)
     if isuppercase(chr)
        string += chr
    end
  end

return string

end
  