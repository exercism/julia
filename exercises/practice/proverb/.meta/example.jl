function recite(pieces)
    if length(pieces) == 0
        return ""
    end
    proverb = ""
    for i in 1:length(pieces)-1
        proverb *= "For want of a $(pieces[i]) the $(pieces[i+1]) was lost.\n"
    end
    proverb *= "And all for the want of a $(pieces[1])."
    proverb
end
