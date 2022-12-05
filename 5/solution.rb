require 'pp'

lines = ARGF.readlines(chomp: true)
sep = lines.index { |l| l.empty? }

amount_of_stacks = lines[sep - 1].strip[-1].to_i
commands = lines[sep + 1, lines.length]

stacks = Array.new(amount_of_stacks) { [] } # [["Z", "N"], ["M", "C", "D"], ["P"]]

lines[0, sep - 1].reverse.each do |line|
    line.split("") # ["    ", "[D] ", "   "]
        .each_slice(4)
        .map { |s| s.join.gsub(/[ \[\]]/,'') } # ["", "D", ""]
        .each_with_index do |stack_item, i|
            if !stack_item.empty?
                stacks[i] << stack_item
            end
        end    
end

commands.each do |command|
    _,how_many_crates,_,from,_,to = command.split(" ")

    crates = stacks[from.to_i - 1].pop(how_many_crates.to_i)
    stacks[to.to_i - 1].concat(crates)
end

stack_top = stacks.inject([]) do |top, s|
    if !s.empty?
        top << s.last
    end
end

pp stack_top.join


