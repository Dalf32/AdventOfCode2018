# frozen_string_literal: true

# node.rb
#
# AUTHOR::  Kyle Mullins

class Node
  attr_reader :child_node_count, :metadata_count

  def initialize(num_child_nodes, num_metadata_entries)
    @child_node_count = num_child_nodes
    @metadata_count = num_metadata_entries
    @children = []
    @metadata = []
  end

  def add_child(child_node)
    @children << child_node
  end

  def add_metadata(metadata_entry)
    @metadata << metadata_entry
  end

  def metadata_total
    @metadata.sum + @children.map(&:metadata_total).sum
  end

  def value
    return @metadata.sum if @child_node_count.zero?

    @metadata.map do |entry|
      next 0 if entry.zero?

      child = @children[entry - 1]
      next 0 if child.nil?

      child.value
    end.sum
  end
end
