# frozen_string_literal: true
# typed: true

require 'zeitwerk'
require 'algorithms'
require 'sorbet-runtime'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/") # Add directories to be autoloaded
loader.setup

class Array
  extend T::Sig

  def to_pk(&priority)
    pk = Containers::PriorityQueue.new
    each do |item|
      priority = yield item
      p [priority, item]
      pk.push(item, priority)
    end
    pk
  end
end

class String
  def numeric?
    to_i.to_s == self
  end
end
