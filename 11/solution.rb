require 'pp'

lines = ARGF.readlines(chomp: true)

monkey_items = [] # [79, 98]
monkey_operations = [] # new = old * 19
monkey_tests = [] # new_monkey = item % 23 ? 2 : 3

dont_give_a_fuck_level = 1

lines.map(&:strip).each_slice(7).each do |m|
    monkey_items << m[1].gsub("Starting items: ", "").split(", ").map(&:to_i)
    monkey_operations << m[2].gsub("Operation: ", "")

    divider = m[3].gsub("Test: divisible by ", "").to_i
    m_true = m[4].gsub("If true: throw to monkey ", "").to_i
    m_false = m[5].gsub("If false: throw to monkey ", "").to_i
    monkey_tests << "worry_level % #{divider} == 0 ? #{m_true} : #{m_false}"

    dont_give_a_fuck_level *= divider
end

inspects = Array.new(monkey_items.length) { 0 }
10000.times do |r|
    monkey_items.each_with_index do |items, i|
        items.each do |old|
            inspects[i] += 1
            worry_level = eval(monkey_operations[i])
            # part1 worry management
            # worry_level = (worry_level / 3).round
            if worry_level > dont_give_a_fuck_level 
                worry_level %= dont_give_a_fuck_level
            end

            new_monkey_i = eval(monkey_tests[i])
            monkey_items[new_monkey_i] << worry_level
        end

        monkey_items[i] = []
    end
end

pp inspects.sort.pop(2).inject(:*)

