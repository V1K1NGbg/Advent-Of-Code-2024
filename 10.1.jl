# julia 10.1.jl

function bfs(map, start_x, start_y)
    q = [(start_x, start_y, 0)]
    v = Set([(start_x, start_y)])
    ends = Set()
    
    while !isempty(q)
        x, y, height = popfirst!(q)
        
        if height == 9
            push!(ends, (x, y))
            continue
        end
        
        for (dx, dy) in ((0, 1), (1, 0), (0, -1), (-1, 0))
            nx, ny = x + dx, y + dy
            if (nx >= 1 && nx <= size(map, 1) && ny >= 1 && ny <= size(map, 2) && map[nx, ny] == height + 1) && !((nx, ny) in v)
                push!(q, (nx, ny, height + 1))
                push!(v, (nx, ny))
            end
        end
    end
    
    return ends
end

function get_score()

    map = hcat([parse.(Int, collect(row)) for row in readlines("input/10.txt") if !isempty(row)]...)'

    starts = [(x, y) for x in 1:size(map, 1), y in 1:size(map, 2) if map[x, y] == 0]

    score = 0

    for (x, y) in starts
        ends = bfs(map, x, y)
        score += length(ends)
    end

    return score
end

println(get_score())
