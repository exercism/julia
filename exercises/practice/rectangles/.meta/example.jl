struct Pt
    c::Integer  # column
    r::Integer  # row
end

function rectangles(strings)
    corners = Set{Pt}()
    horiz = Set{Pt}()
    vert = Set{Pt}()
    for (y, line) in enumerate(strings)
        for (x, char) in enumerate(line)
            if char == '+'
                push!(corners, Pt(x, y))
                # corners are also valid for top & bottom
                push!(horiz, Pt(x, y))
                push!(vert, Pt(x, y))
            elseif char == '-'
                push!(horiz, Pt(x, y))
            elseif char == '|'
                push!(vert, Pt(x, y))
            end
        end
    end

    # get top-left and bottom-right corners
    possibles = [(pt1, pt2) for pt1 in corners, pt2 in corners 
                    if pt1.r < pt2.r && pt1.c < pt2.c
                        # check bottom-left and top-right
                        && Pt(pt1.c, pt2.r) ∈ corners 
                        && Pt(pt2.c, pt1.r) ∈ corners]
    
    sides(pt1, pt2) = all([Pt(pt1.c, row) ∈ vert for row in pt1.r:pt2.r]) &&
                        all([Pt(pt2.c, row) ∈ vert for row in pt1.r:pt2.r])

    top_bottom(pt1, pt2) = all([Pt(col, pt1.r) ∈ horiz for col in pt1.c:pt2.c]) &&
                            all([Pt(col, pt2.r) ∈ horiz for col in pt1.c:pt2.c])

    [(pt1, pt2) for (pt1, pt2) in possibles 
                if sides(pt1, pt2) && top_bottom(pt1, pt2)] |> length
end
