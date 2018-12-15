# frozen_string_literal: true

# linked_list.rb
#
# AUTHOR::  Kyle Mullins

class Node
  attr_accessor :value, :next, :prev

  def initialize(value, next_node: nil, prev_node: nil)
    @value = value
    @next = next_node
    @prev = prev_node
  end
end

class LinkedList
  include Enumerable

  attr_reader :size

  def initialize(*list)
    @head = nil
    @size = 0

    list.first.each(&method(:push)) if list.first.is_a?(Enumerable)
  end

  def first
    return nil if empty?

    @head.value
  end

  def last
    return nil if empty?

    tail.value
  end

  def empty?
    @size.zero?
  end

  def push(obj)
    if empty?
      @head = Node.new(obj)
      @head.next = @head.prev = @head
    else
      new_node = Node.new(obj, next_node: @head, prev_node: tail)
      tail.next = new_node
      @head.prev = new_node
    end

    @size += 1
    self
  end

  def pop(n = 1)
    popped = Array.new(n) { pop_single }.compact
    return popped.first if popped.size <= 1

    popped
  end

  def prepend(obj)
    push(obj)
    @head = tail
    self
  end

  def shift(n = 1)
    shifted = Array.new(n) { shift_single }.compact
    return shifted.first if shifted.size <= 1

    shifted
  end

  def rotate(n = 1)
    return self if size <= 1

    n.abs.times do
      @head = @head.next if n.positive?
      @head = @head.prev if n.negative?
    end

    self
  end

  def each
    return if empty?

    cur_node = @head

    loop do
      yield cur_node.value
      break if cur_node == tail

      cur_node = cur_node.next
    end
  end

  def to_s
    to_a.to_s
  end

  private

  def tail
    return nil if empty?

    @head.prev
  end

  def pop_single
    return nil if empty?

    if size == 1
      removed_node = @head
      @head = nil
    else
      removed_node = tail
      @head.prev = removed_node.prev
      tail.next = @head
    end

    @size -= 1
    removed_node.value
  end

  def shift_single
    return pop_single if size <= 1

    removed_node = @head
    tail.next = removed_node.next
    @head = removed_node.next
    @head.prev = removed_node.prev

    @size -= 1
    removed_node.value
  end
end
