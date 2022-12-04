require 'pp'

pairs = ARGF.readlines.map(&:strip)

overlap_count = 0

pairs.each do |pair|
    sections = pair.split(",")
        .map { |e| e.split("-").map(&:to_i) }
        .sort_by(&:first)

    if sections[0][1] >= sections[1][0]
        overlap_count += 1
    end
end

pp overlap_count

