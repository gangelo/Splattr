require 'base/base_creature'
require 'modules/gender'

class Dog < BaseCreature
  def initialize(gender,name,age)
		super gender,name,age*7	# Calc dog years. age*7, not exactly true, but it is what most people use.
  end

	def age_in_human_years
		@age/7
	end
end
