# frozen_string_literal: true

# light.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/point'

class Light
  attr_reader :position, :velocity

  def self.from_str(light_str)
    parts = light_str.split(/[<>]/)
    position = Point.new(*parts[1].split(',').map(&:to_i))
    velocity = Point.new(*parts[3].split(',').map(&:to_i))
    Light.new(position, velocity)
  end

  def initialize(position, velocity)
    @position = position
    @velocity = velocity
  end

  def move
    @position += @velocity
  end

  def to_s
    "#{@position} moving at #{@velocity} / tick"
  end
end
