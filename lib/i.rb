module I
  def self.to_map
    $<.map{|l| l.chomp.chars}.to_map
  end
end
