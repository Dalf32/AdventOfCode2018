# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

require 'date'
require_relative 'guard_record'
require_relative 'guard_history'

module Day04
  class Part1
    def process_input(input_lines)
      sorted_records = input_lines.map do |record_str|
        split_record = record_str.split(']')
        [DateTime.parse(split_record.first[1..-1]), split_record.last]
      end.sort_by(&:first)

      last_id = 0

      sorted_records.map do |(date, action_str)|
        GuardRecord.from_parts(date, action_str, last_id).tap do |guard_record|
          last_id = guard_record.id
        end
      end
    end

    def solve(input)
      guards = input.group_by(&:id).map { |(id, records)| GuardHistory.new(id, records) }

      most_times_asleep = 0
      best_time = 0
      sleepiest_guard = guards.max_by(&:minutes_asleep)

      (0..59).each do |minute|
        times_asleep = sleepiest_guard.times_asleep_at(minute)
        next unless times_asleep > most_times_asleep

        most_times_asleep = times_asleep
        best_time = minute
      end

      best_time * sleepiest_guard.id
    end
  end

  class Part2
    def process_input(input_lines)
      sorted_records = input_lines.map do |record_str|
        split_record = record_str.split(']')
        [DateTime.parse(split_record.first[1..-1]), split_record.last]
      end.sort_by(&:first)

      last_id = 0

      sorted_records.map do |(date, action_str)|
        GuardRecord.from_parts(date, action_str, last_id).tap do |guard_record|
          last_id = guard_record.id
        end
      end
    end

    def solve(input)
      guards = input.group_by(&:id).map { |(id, records)| GuardHistory.new(id, records) }

      most_times_asleep = 0
      best_time = 0
      sleepiest_guard = nil

      guards.each do |guard|
        (0..59).each do |minute|
          times_asleep = guard.times_asleep_at(minute)
          next unless times_asleep > most_times_asleep

          most_times_asleep = times_asleep
          best_time = minute
          sleepiest_guard = guard
        end
      end

      best_time * sleepiest_guard.id
    end
  end
end
