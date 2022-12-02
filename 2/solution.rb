require 'pp'

games = ARGF.readlines

shapes_value = {
    "X" => 1,
    "Y" => 2,
    "Z" => 3
}

outcomes = {
    "A X" => 3,
    "A Y" => 6,
    "A Z" => 0,
    "B X" => 0,
    "B Y" => 3,
    "B Z" => 6,
    "C X" => 6,
    "C Y" => 0,
    "C Z" => 3,
}

shapes = {
    "A X" => "Z",
    "A Y" => "X",
    "A Z" => "Y",
    "B X" => "X",
    "B Y" => "Y",
    "B Z" => "Z",
    "C X" => "Y",
    "C Y" => "Z",
    "C Z" => "X",
}

total_score = 0

games.each do |game|
    opponent_move, expected_outcome = game.split
    your_move = shapes[game.strip]

    total_score += shapes_value[your_move]
    total_score += outcomes["#{opponent_move} #{your_move}"]
end

pp total_score

