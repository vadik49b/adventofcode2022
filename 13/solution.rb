require 'pp'

lines = ARGF.readlines(chomp: true)

def check(left_packet, right_packet)
    left = left_packet.shift
    right = right_packet.shift

    if left.nil? && right.nil?
        return true
    end

    if left.nil? && !right.nil?
        return true
    end

    if !left.nil? && right.nil?
        return false
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

    if left == right
        return check(left_packet, right_packet)
    end

    return left < right
end

i = 1
sum = 0
lines.each_slice(3) do |packets|
    left_packet = eval(packets[0])
    right_packet = eval(packets[1])

    if check(left_packet, right_packet)
        sum += i
    end

    i += 1
end

pp sum
