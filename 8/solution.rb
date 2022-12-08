require 'pp'

lines = ARGF.readlines(chomp: true)

trees = lines.map { |line| line.split("").map(&:to_i) }
M, N = lines.length, lines[0].length

def look(trees, i, j, di, dj)
    visible = true
    score = 0

    ii, jj = i + di, j + dj
    while 0 <= ii && ii < M && 0 <= jj && jj < N do
        score += 1

        if trees[i][j] <= trees[ii][jj]
            visible = false
            break
        end

        ii += di
        jj += dj
    end

    return visible, score
end

visible_trees_count = 0
max_tree_score = -1

(0...M).each do |i|
    (0...N).each do |j|
        visible_up, score_up = look(trees, i, j, -1, 0)
        visible_left, score_left = look(trees, i, j, 0, -1)
        visible_right, score_right = look(trees, i, j, 0, 1)
        visible_down, score_down = look(trees, i, j, 1, 0)

        visible = visible_up || visible_left || visible_right || visible_down
        visible_trees_count += 1 if visible

        tree_score = score_up * score_left * score_right * score_down
        max_tree_score = tree_score if tree_score > max_tree_score
    end
end

pp visible_trees_count
pp max_tree_score