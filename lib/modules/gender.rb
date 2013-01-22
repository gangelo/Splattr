# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'test/unit/assertions'

module Gender
	MALE=:male
	FEMALE=:female	
	class InvalidGenderException < StandardError; end

	attr_reader :gender

	def gender=(value)
		raise Gender::InvalidGenderException.new('gender must be Gender::MALE or Gender::FEMALE')	unless value==Gender::MALE || value==Gender::FEMALE
		@gender=value
	end

	def male?
		@gender==Gender::MALE
	end

	def female?
		@gender==Gender::FEMALE
	end
end
