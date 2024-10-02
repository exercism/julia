struct InvalidPosition <: Exception
    message::String
end

struct Queen
    row::Int
    col::Int
    Queen(row::Int, col::Int) = 
        if row < 0
            throw(InvalidPosition("row must be positive"))
        elseif row > 7
            throw(InvalidPosition("row not on board"))
        elseif row < 0
            throw(InvalidPosition("column must be positive"))
        elseif col > 7
            throw(InvalidPosition("column not on board"))
        else
            new(row, col)
        end
end

function canattack(white::Queen, black::Queen)
    white.row == black.row || white.col == black.col || abs(white.row - black.row) == abs(white.col - black.col)
end
