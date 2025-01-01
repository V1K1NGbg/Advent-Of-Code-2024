# julia 10.2.jl

function get_score()
    map = collect.(readlines("input/10.txt"))
    rows = length(map)
    cols = length(map[1])
    height = [parse(Int, map[r][c]) for r in 1:rows, c in 1:cols]

    dp = fill(-1, rows, cols)
    function ways(r, c)
        if dp[r, c] != -1
            return dp[r, c]
        end
        if height[r, c] == 9
            dp[r, c] = 1
            return 1
        end
        dp[r, c] = 0
        for (dr, dc) in ((1,0), (-1,0), (0,1), (0,-1))
            nr, nc = r+dr, c+dc
            if 1 ≤ nr ≤ rows && 1 ≤ nc ≤ cols && height[nr, nc] == height[r, c] + 1
                dp[r, c] += ways(nr, nc)
            end
        end
        return dp[r, c]
    end

    score = 0
    for r in 1:rows, c in 1:cols
        if height[r, c] == 0
            score += ways(r, c)
        end
    end
    return score
end

println(get_score())