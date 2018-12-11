# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

module Day02
  def process_input(input_lines)
    input_lines
  end

  class Part1
    include Day02

    def solve(input)
      has_2_count = 0
      has_3_count = 0

      input.each do |id|
        counts = calc_counts(id)
        has_2_count += 1 if counts.include?(2)
        has_3_count += 1 if counts.include?(3)
      end

      has_2_count * has_3_count
    end

    def calc_counts(id)
      id.chars.sort.chunk { |c| c }.map { |_c, chars| chars.count }.uniq
    end
  end

  class Part2
    include Day02

    def solve(input)
      loop do
        head_id, *rest_ids = *input
        break if rest_ids.empty?

        rest_ids.each do |other_id|
          if single_difference?(head_id, other_id)
            return remove_difference(head_id, other_id)
          end
        end

        input = rest_ids
      end
    end

    def single_difference?(id1, id2)
      id1.chars.zip(id2.chars).reject { |a, b| a == b }.count == 1
    end

    def remove_difference(id1, id2)
      id1.chars.zip(id2.chars).select { |a, b| a == b }.map(&:first).join
    end
  end
end
