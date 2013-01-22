# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'people/male'
require 'people/female'

module SpecHelpers
	def get_male(name,age)
		Male.new name, age
	end

	def get_female(name,age)
		Female.new name, age
	end
end
