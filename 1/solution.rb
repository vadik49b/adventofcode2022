require 'pp'

lines = ARGF.readlines

calories_per_elf = []

calories = 0
lines.each do |line|
    if line.strip.empty?
        calories_per_elf << calories
        calories = 0
    else
        calories += line.to_i
    end
end

calories_per_elf << calories

pp calories_per_elf.sort.reverse.slice(0, 3).sum

