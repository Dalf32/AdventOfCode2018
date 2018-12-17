# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

require_relative 'light'
require_relative '../Common/rectangle'

module Day10
  def process_input(input_lines)
    input_lines.map do |light_str|
      Light.from_str(light_str)
    end
  end

  def find_message(lights)
    min_extent = 100_000_000_000
    min_extent_points = []
    iterations = 0

    loop do
      lights.map(&:move)
      points = lights.map(&:position)
      extent = bounding_box(points).area

      break if extent > min_extent

      iterations += 1
      min_extent = extent
      min_extent_points = points
    end

    [iterations, min_extent_points]
  end

  def bounding_box(points)
    x_s = points.map(&:x)
    y_s = points.map(&:y)
    Rectangle.new(Point.new(x_s.min, y_s.max),
                  Point.new(x_s.max, y_s.min))
  end

  class Part1
    include Day10

    def solve(input)
      lights = *find_message(input).last

      bound = bounding_box(lights)
      grid = Array.new(bound.height + 1) { Array.new(bound.width + 1, '.') }

      lights.each { |p| grid[p.y - bound.bottom_right.y][p.x - bound.top_left.x] = '#' }

      puts grid.map(&:join).join("\n")
    end
  end

  class Part2
    include Day10

    def solve(input)
      find_message(input).first
    end
  end
end
