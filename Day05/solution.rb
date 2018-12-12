# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

module Day05
  def process_input(input_lines)
    input_lines.first
  end

  def fully_react_polymer(polymer)
    units = polymer.chars
    index = 1

    while index < units.count
      if reacts?(units[index - 1], units[index])
        react_units(units, index)
        index = [index - 1, 1].max
      else
        index += 1
      end
    end

    units.join
  end

  def reacts?(unit_a, unit_b)
    unit_a.casecmp(unit_b).zero? && unit_a != unit_b
  end

  def react_units(units, index)
    units.delete_at(index)
    units.delete_at(index - 1)
  end

  class Part1
    include Day05

    def solve(input)
      fully_react_polymer(input).length
    end
  end

  class Part2
    include Day05

    def solve(input)
      shortest_polymer = input.length

      ('a'..'z').each do |unit|
        reduced_polymer = remove_unit(input, unit)
        reacted_length = fully_react_polymer(reduced_polymer).length
        shortest_polymer = reacted_length if reacted_length < shortest_polymer
      end

      shortest_polymer
    end

    def remove_unit(polymer, unit)
      polymer.gsub(/#{unit}/i, '')
    end
  end
end
