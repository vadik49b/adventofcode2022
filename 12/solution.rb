require 'pp'

lines = ARGF.readlines(chomp: true)

map = []
lines.each do |line|
    map << line.split("")
end

M, N = lines.length, lines[0].length

sx = lines.index { |line| line.include?("S") }
sy = lines[sx].index("S")
S = [sx, sy]

def get_edges(map, x, y)
    all_edges = [
        [x, y+1], [x+1, y], [x, y-1], [x-1, y]
    ].filter { |s| s[0] >= 0 && s[0] < M && s[1] >= 0 && s[1] < N }

    all_edges.filter do |s|
        from = map[x][y] == "S" ? "a" : map[x][y]
        to = map[s[0]][s[1]] == "E" ? "z" : map[s[0]][s[1]]

        from.bytes[0] + 1 >= to.bytes[0]
    end
end

visited = [S]
steps = [S]
distance = {
    S => 0
}

while !steps.empty? do
    step = steps.shift
    x, y = step

    if map[x][y] == "E"
        pp "finish #{x}, #{y}, #{distance[[x, y]]}"
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