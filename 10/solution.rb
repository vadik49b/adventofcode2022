require 'pp'

lines = ARGF.readlines(chomp: true)

log = []
x = 1
lines.each do |line|
    if line == "noop"
        log << x
    elsif
        log << x << x
        x += line.gsub("addx ", "").to_i
    end
end

crt = []
6.times do
    crt_row = []
    (0...40).each do |i|
        x = log.shift
        if i - 1 <= x && x <= i + 1 
            crt_row << "#"
        elsif
            crt_row << "."
        end
    end

    crt << crt_row.join
end

pp crt
