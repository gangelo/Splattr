require 'base/base_creature'
require 'modules/gender'

class Male < BaseCreature
  def initialize(name,age)
		super Gender::MALE,name,age
  end
end
