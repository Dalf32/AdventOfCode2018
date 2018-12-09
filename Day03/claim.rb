# frozen_string_literal: true

# claim.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/rectangle'

class Claim
  attr_reader :id, :area

  def self.from_str(str)
    matches = str.match(/#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/)

    top_left_corner = Point.new(matches[:x].to_i, matches[:y].to_i)
    Claim.new(matches[:id], top_left_corner, matches[:width].to_i,
              matches[:height].to_i)
  end

  def initialize(id, top_left_corner, width, height)
    @id = id
    @width = width
    @height = height
    @area = Rectangle.new(top_left_corner,
                          Point.new(top_left_corner.x + @width - 1,
                                    top_left_corner.y + @height - 1))
  end

  def intersects?(other_claim)
    @area.intersects?(other_claim.area)
  end

  def contains?(point)
    @area.contains_point?(point)
  end

  def overlapping_points(other_claim)
    @area.overlapping_area(other_claim.area).points
  end

  def to_s
    "##{@id} @ #{@area}"
  end
end
