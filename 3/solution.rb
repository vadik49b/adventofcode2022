require 'pp'

rucksacks = ARGF.readlines.map(&:strip)

def get_priority(item)
    ascii_code = item.bytes[0]

    ascii_code <= 90 ? ascii_code - 38 : ascii_code - 96
end

priorities = []

rucksacks.each_slice(3) do |group|
    elf_1, elf_2, elf_3 = group.map { |g| g.split("") }

    common_item, = elf_1 & elf_2 & elf_3

    priorities << get_priority(common_item)
end

pp priorities.sum

