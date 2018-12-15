# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

require_relative 'step'
require_relative '../Common/worker'

module Day07
  def process_input(input_lines)
    ('A'..'Z').map { |letter| [letter, Step.new(letter)] }.to_h.tap do |steps|
      input_lines.each do |rule|
        rule_words = rule.split
        steps[rule_words[7]].add_dependency(steps[rule_words[1]])
      end
    end.values
  end

  class Part1
    include Day07

    def solve(input)
      completed_steps = []

      until input.empty?
        current_step = input.select(&:ready?).min_by(&:letter)
        current_step.complete
        completed_steps << current_step
        input.delete(current_step)
      end

      completed_steps.map(&:letter).join
    end
  end

  class Part2
    include Day07

    def solve(input)
      steps_queue = []
      completed_steps = []
      current_time = 0
      workers = (1..5).map { |id| Worker.new(id) }

      until input.empty? && workers.all?(&:ready?)
        ready_steps = input.select(&:ready?).sort_by(&:letter)
        steps_queue += ready_steps
        input -= ready_steps

        while steps_queue.any? && workers.any?(&:ready?)
          step = steps_queue.shift
          workers.find(&:ready?).assign_task(step)
        end

        workers.select(&:working?).each do |worker|
          step = worker.tick
          completed_steps << step if step.complete?
        end

        current_time += 1
      end

      current_time
    end
  end
end
