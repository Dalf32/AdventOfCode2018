# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

require_relative 'node'

module Day08
  def process_input(input_lines)
    create_node(input_lines.first.split.map(&:to_i))
  end

  def create_node(data)
    Node.new(*data.shift(2)).tap do |node|
      node.child_node_count.times do
        node.add_child(create_node(data))
      end

      node.metadata_count.times do
        node.add_metadata(data.shift)
      end
    end
  end

  class Part1
    include Day08

    def solve(input)
      input.metadata_total
    end
  end

  class Part2
    include Day08

    def solve(input)
      input.value
    end
  end
end
