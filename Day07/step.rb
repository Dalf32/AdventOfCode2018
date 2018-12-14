# frozen_string_literal: true

# step.rb
#
# AUTHOR::  Kyle Mullins

class Step
  attr_reader :letter

  def initialize(letter)
    @letter = letter
    @complete = false
    @dependencies = []
  end

  def add_dependency(dep)
    @dependencies << dep
  end

  def dependencies?
    !@dependencies.empty?
  end

  def ready?
    @dependencies.all?(&:complete?)
  end

  def complete?
    @complete
  end

  def complete
    @complete = true
  end

  def duration
    60 + @letter.ord - 'A'.ord + 1
  end

  def eql?(other_step)
    @letter == other_step.letter
  end

  def ==(other_step)
    eql?(other_step)
  end

  def to_s
    "Step #{@letter} depends on Steps: #{@dependencies.map(&:letter).join(', ')}"
  end
end
