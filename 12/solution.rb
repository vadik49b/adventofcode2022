require 'pp'

lines = ARGF.readlines(chomp: true)

map = []
lines.each do |line|
    map << line.split("")
end

M, N = lines.length, lines[0].length

Sx = lines.index { |line| line.include?("S") }
Sy = lines[Sx].index("S")
S = [Sx, Sy]

Ex = lines.index { |line| line.include?("E") }
Ey = lines[Ex].index("E")
E = [Ex, Ey]

def elevation(map, x, y)
    if map[x][y] == "S"
        return "a".bytes[0]
    end

    if map[x][y] == "E"
        return "z".bytes[0]
    end

    map[x][y].bytes[0]
end

def get_edges(map, x, y)
    all_edges = [
        [x, y+1], [x+1, y], [x, y-1], [x-1, y]
    ].filter { |s| s[0] >= 0 && s[0] < M && s[1] >= 0 && s[1] < N }

    all_edges.filter do |s|
        elevation(map, s[0], s[1]) + 1 >= elevation(map, x, y)
    end
end

visited = [E]
steps = [E]
distance = {
    E => 0
}

while !steps.empty? do
    step = steps.shift
    x, y = step

    if map[x][y] == "a" || map[x][y] == "S"
        pp "finish [#{x}, #{y}], distance=#{distance[[x, y]]}"
        break
    end

    get_edges(map, x, y).each do |edge|
        if !visited.include?(edge)
            visited << edge
            steps << edge
            distance[edge] = distance[step] + 1
        end
    end
end