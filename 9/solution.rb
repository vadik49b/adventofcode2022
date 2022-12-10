require 'pp'

lines = ARGF.readlines(chomp: true)

Position = Struct.new(:x, :y)

STEPS = {
    R: Position.new(1, 0),
    U: Position.new(0, 1),
    L: Position.new(-1, 0),
    D: Position.new(0, -1)
}


snake = Array.new(10) { Position.new(0, 0) }
tail_position_log = [snake.last.clone]

lines.each do |line|
    direction = STEPS[line[0].to_sym]
    distance = line[2, line.length].to_i

    distance.times do
        snake[0].x += direction.x
        snake[0].y += direction.y

        (1...snake.length).each do |i|
            dx = snake[i - 1].x - snake[i].x
            dy = snake[i - 1].y - snake[i].y

            if dx.abs > 1 || dy.abs > 1
                snake[i].x += dx <=> 0
                snake[i].y += dy <=> 0   
            end
        end

        tail_position_log << snake.last.clone
    end
end

pp tail_position_log.uniq.length

