require 'base/base_thingy'
require 'modules/gender'

class Anaconda < BaseCreature
  def initialize(gender,age)
		super gender,'Anaconda',age
  end
end
