# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

module Day01
  class Part1
    def process_input(input_lines)
      input_lines.map(&:to_i)
    end

    def solve(input)
      input.sum
    end
  end

  class Part2
    def process_input(input_lines)
      input_lines.map(&:to_i)
    end

    def solve(input)
      frequencies = [0]

      loop do
        input.each do |change|
          new_freq = frequencies.last + change
          return new_freq if frequencies.include?(new_freq)

          frequencies << new_freq
        end
      end
    end
  end
end
