# frozen_string_literal: true

##
# solution.rb
#
# AUTHOR::  Kyle Mullins
##

require_relative 'claim'

module Day03
  class Part1
    def process_input(input_lines)
      input_lines.map { |claim_str| Claim.from_str(claim_str) }
    end

    def solve(input)
      overlapping = []

      loop do
        head_claim, *rest_claims = *input
        break if rest_claims.empty?

        rest_claims.each do |other_claim|
          if head_claim.intersects?(other_claim)
            overlapping += head_claim.overlapping_points(other_claim)
          end
        end

        input = rest_claims
      end

      overlapping.uniq.count
    end
  end

  class Part2
    def process_input(input_lines)
      input_lines.map { |claim_str| Claim.from_str(claim_str) }
    end

    def solve(input)
      overlap_counts = input.map(&:id).zip([0] * input.count).to_h

      loop do
        head_claim, *rest_claims = *input
        break if rest_claims.empty?

        rest_claims.each do |other_claim|
          if head_claim.intersects?(other_claim)
            overlap_counts[head_claim.id] += 1
            overlap_counts[other_claim.id] += 1
          end
        end

        input = rest_claims
      end

      overlap_counts.select { |_id, count| count.zero? }.keys.first
    end
  end
end
