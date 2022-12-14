require 'pp'

lines = ARGF.readlines(chomp: true)

def check(left_packet, right_packet)
    if left_packet.empty? || right_packet.empty?
        return left_packet.length - right_packet.length != 1
    end

    left = left_packet.shift
    right = right_packet.shift

    if left.is_a?(Integer) && right.is_a?(Integer)
        return left < right
    end

    if left.is_a?(Array) && right.is_a?(Array)
        return check(left, right)
    end

    if left.is_a?(Integer) && right.is_a?(Array)
        return check([left], right)
    end

    if left.is_a?(Array) && right.is_a?(Integer)
        return check(left, [right])
    end

    return check(left_packet, right_packet)    
end

lines = lines.filter { |l| !l.empty? }
before_divider_1 = lines.filter { |l| check(eval(l), eval("[[2]]")) }
before_divider_2 = lines.filter { |l| check(eval(l), eval("[[6]]")) }

pp (before_divider_1.length + 1) * (before_divider_2.length + 2)