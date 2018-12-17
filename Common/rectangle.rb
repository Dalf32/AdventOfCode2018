# frozen_string_literal: true

# rectangle.rb
#
# AUTHOR::  Kyle Mullins

require_relative 'point'

class Rectangle
  attr_reader :top_left, :bottom_right

  def initialize(top_left_corner, bottom_right_corner)
    @top_left = top_left_corner
    @bottom_right = bottom_right_corner
  end

  def intersects?(other_rect)
    @top_left.x <= other_rect.bottom_right.x &&
      @bottom_right.x >= other_rect.top_left.x &&
      @top_left.y <= other_rect.bottom_right.y &&
      @bottom_right.y >= other_rect.top_left.y
  end

  def contains_point?(point)
    point.inside?(@top_left, @bottom_right)
  end

  def width
    (@top_left.x - @bottom_right.x).abs
  end

  def height
    (@top_left.y - @bottom_right.y).abs
  end

  def area
    width * height
  end

  def overlapping_area(other_rect)
    new_top_left = Point.new([@top_left.x, other_rect.top_left.x].max,
                             [@top_left.y, other_rect.top_left.y].max)
    new_bottom_right = Point.new([@bottom_right.x, other_rect.bottom_right.x].min,
                                 [@bottom_right.y, other_rect.bottom_right.y].min)

    Rectangle.new(new_top_left, new_bottom_right)
  end

  def points
    [].tap do |points|
      (@top_left.x..@bottom_right.x).each do |x|
        (@top_left.y..@bottom_right.y).each do |y|
          points << Point.new(x, y)
        end
      end
    end
  end

  def to_s
    "#{@top_left} - #{@bottom_right}"
  end
end
