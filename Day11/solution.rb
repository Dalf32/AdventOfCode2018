# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

require_relative '../Common/point'

module Day11
  def process_input(input_lines)
    input_lines.first.to_i
  end

  def fuel_grid(serial_num)
    Array.new(300) do |y|
      y += 1

      Array.new(300) do |x|
        power_level(x + 1, y, serial_num)
      end
    end
  end

  def power_level(x, y, serial_num)
    rack_id = x + 10
    power = ((rack_id * y) + serial_num) * rack_id
    power.digits[2].to_i - 5
  end

  def locate_max_fuel(fuel_cells, square_size)
    max_fuel = 0
    max_fuel_corner = Point.new(0, 0)
    iterations = 301 - square_size

    iterations.times do |x|
      iterations.times do |y|
        y2 = y + square_size - 1
        x2 = x + square_size - 1
        fuel = fuel_cells[y..y2].map { |row| row[x..x2] }.flatten.sum
        next unless fuel > max_fuel

        max_fuel = fuel
        max_fuel_corner = Point.new(x + 1, y + 1)
      end
    end

    [max_fuel, max_fuel_corner]
  end

  class Part1
    include Day11

    def solve(input)
      locate_max_fuel(fuel_grid(input), 3).last
    end
  end

  class Part2
    include Day11

    def solve(input)
      fuel_grid = fuel_grid(input)
      max_fuel = 0
      max_fuel_square_size = 0
      max_fuel_square_corner = Point.new(0, 0)

      300.times.each do |square_size|
        square_size += 1
        break if max_fuel > 4 * square_size**2

        fuel, fuel_corner = *locate_max_fuel(fuel_grid, square_size)
        break if fuel.zero?
        next unless fuel > max_fuel

        max_fuel = fuel
        max_fuel_square_size = square_size
        max_fuel_square_corner = fuel_corner
      end

      "#{max_fuel_square_corner} #{max_fuel_square_size}"
    end
  end
end
