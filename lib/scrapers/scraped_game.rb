class ScrapedGame

  attr_accessor :name, :console, :release_date, :region, :boxart, :tags

  def initialize
    self.name = ''
    self.console = ''
    self.release_date = nil
    self.region = ''
    self.boxart = ''
    self.tags = ''
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end
