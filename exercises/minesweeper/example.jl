# function to check if the current character represents a mine or not
ismine(ch) = (ch == '*' ? 1 : 0)

function annotate(minefield)

    # ans will store our final output of the program
    ans = []

    # i represents row number
    for i in 1 : length(minefield)

        # ans_row string will be an element of our ans
        ans_row = ""

        # j represents column number
        for j in 1 : length(minefield[i])

            # check if it is a mine or not
            if minefield[i][j] != '*'

                # calculate the boundary indices of neighbourhood
                r1 = max(1, i - 1)
                r2 = min(i + 1, length(minefield))
                c1 = max(1, j - 1)
                c2 = min(j + 1, length(minefield[i]))

                # count will store the number of mines in the neighbourhood
                count = 0
                for x in r1:r2, y in c1:c2
                    count += ismine(minefield[x][y])
                end

                # append space char if no mine is found else append count
                if count == 0
                    ans_row *= ' '
                else
                    ans_row *= string(count)
                end

            # if current cell represents mine then append it
            else
                ans_row *= '*'
            end
        end

        # push the calculated row_string to our ans
        push!(ans, ans_row)
    end

    return ans
end
