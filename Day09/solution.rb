# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

require_relative '../Common/linked_list'

module Day09
  def process_input(input_lines)
    words = input_lines.first.split
    [words[0].to_i, words[6].to_i]
  end

  def play_game(player_count, marble_count)
    circle = LinkedList.new([0])
    player_scores = [0] * player_count

    marble_count.times do |marble|
      marble += 1 # because it counts from 0

      if (marble % 23).zero?
        player_scores[marble % player_count] += circle.rotate(-7).shift + marble
      else
        circle.rotate(2).prepend(marble)
      end
    end

    player_scores.max
  end

  class Part1
    include Day09

    def solve(input)
      play_game(*input)
    end
  end

  class Part2
    include Day09

    def solve(input)
      player_count, marble_count = *input
      play_game(player_count, marble_count * 100)
    end
  end
end
