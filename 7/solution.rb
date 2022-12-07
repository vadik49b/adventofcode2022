require 'pp'

lines = ARGF.readlines(chomp: true)

dir_size = {}
key = 0
dir_calculation = [] # { "/": 48381165, "0_a": 2312, "1_b": 433 }

lines.each do |line|
    if line == "$ cd .."
        dir = dir_calculation.pop
        dir_size["#{key}_#{dir[:name]}"] = dir[:size]
        key += 1
    elsif line.start_with?("$ cd")
        dir = { name: line.gsub("$ cd ", ""), size: 0 }
        dir_calculation << dir
    elsif line.match(/\d+ \w+/)
        file_size = line.split(" ")[0].to_i
        dir_calculation.each { |dir| dir[:size] += file_size }
    end
end

root_dir = dir_calculation[0]
dir_calculation[1, dir_calculation.length].each do |dir|
    dir_size["#{key}_#{dir[:name]}"] = dir[:size]
    key += 1
end

# part1
pp dir_size.values.filter { |v| v <= 100000 }.sum

# part2
total_disk_space = 70000000
required_unused_space = 30000000
need_to_freeup = required_unused_space - (total_disk_space - root_dir[:size])
pp dir_size.values.find { |v| v >= need_to_freeup }

