# frozen_string_literal: true

# worker.rb
#
# AUTHOR::  Kyle Mullins

class Worker
  def initialize(id)
    @id = id
    @task = nil
    @progress = 0
  end

  def ready?
    @task.nil?
  end

  def working?
    !ready?
  end

  def assign_task(task)
    @task = task
    @progress = 0
  end

  def tick
    @progress += 1
    return @task if @task.nil? || @progress < @task.duration

    @task.complete
    done_task = @task
    @task = nil
    done_task
  end

  def to_s
    "Worker ##{@id}"
  end
end
