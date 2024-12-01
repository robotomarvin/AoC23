# frozen_string_literal: true
# typed: strict

module I
  extend T::Sig

  sig { returns(Map[String]) }
  def self.to_map
    $<.map { |l| l.chomp.chars }.to_map
  end
end
