# frozen_string_literal: true

# guard_record.rb
#
# AUTHOR::  Kyle Mullins

class GuardRecord
  attr_reader :id, :time

  def self.from_parts(time, action_str, last_id)
    if action_str.include?('Guard #')
      last_id = action_str.split(' ')[1][1..-1].to_i
      action_str = 'begins shift'
    end

    action_map = { 'begins shift' => :begin_shift,
                   'falls asleep' => :fall_asleep, 'wakes up' => :wake_up }
    GuardRecord.new(last_id, time, action_map[action_str.strip])
  end

  def initialize(id, time, action)
    @id = id
    @time = time
    @action = action
  end

  def begin_shift?
    @action == :begin_shift
  end

  def fall_asleep?
    @action == :fall_asleep
  end

  def wake_up?
    @action == :wake_up
  end

  def to_s
    "[#{@time}] Guard ##{@id} #{@action}"
  end
end
