require 'zeitwerk'
require 'algorithms'

loader = Zeitwerk::Loader.new
loader.push_dir(__dir__ + '/')  # Add directories to be autoloaded
loader.setup

class Array
  def to_pk(&priority)
    pk = Containers::PriorityQueue.new
    self.each do |item|
      priority = yield item
      p [priority, item]
      pk.push(item, priority)
    end
    pk
  end

  def to_map
    Map.new(self)
  end
end

class String
  def is_numeric?
    self.to_i.to_s == self
  end
end
