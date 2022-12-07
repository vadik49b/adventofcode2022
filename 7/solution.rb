require 'pp'

lines = ARGF.readlines(chomp: true)

dir_size = []
pending_dir_size = []

lines.each do |line|
    if line == "$ cd .."
        dir_size << pending_dir_size.pop
    elsif line.start_with?("$ cd")
        pending_dir_size << 0
    elsif line.match(/\d+ \w+/)
        file_size = line.split(" ")[0].to_i
        pending_dir_size = pending_dir_size.map { |s| s += file_size }
    end
end

dir_size.concat(pending_dir_size)

# part1
pp dir_size.filter { |v| v <= 100000 }.sum

# part2
total_disk_space = 70000000
required_unused_space = 30000000
root_dir_size = pending_dir_size[0]
need_to_freeup = required_unused_space - (total_disk_space - root_dir_size)
pp dir_size.find { |v| v >= need_to_freeup }

