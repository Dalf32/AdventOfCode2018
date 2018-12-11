# frozen_string_literal: true

# guard_history.rb
#
# AUTHOR::  Kyle Mullins

class GuardHistory
  attr_reader :id, :records

  def initialize(id, records)
    @id = id
    @records = records
  end

  def sleep_periods
    @sleep_periods ||= @records.reject(&:begin_shift?).slice_after(&:wake_up?)
                               .map { |(sleep, wake)| (sleep.time.minute..(wake.time.minute - 1)) }
  end

  def times_asleep
    sleep_periods.count
  end

  def minutes_asleep
    sleep_periods.map(&:count).sum
  end

  def times_asleep_at(minute)
    sleep_periods.count { |period| period.include?(minute) }
  end
end
