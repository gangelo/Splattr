require 'modules/gender'
require 'base/base_thingy'

class BaseCreature < BaseThingy
	include Gender
	
	def initialize(gender,name,age)
		@gender=gender
		super name, age
  end

	protected :gender=
end
