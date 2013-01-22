# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'test/unit/assertions'

module Age
	class InvalidAgeException < StandardError;	end
	
  attr_accessor :age

	def age=(value)
		raise Age::InvalidAgeException.new('age must not be nil?') if value.nil?		
		@age=value
	end

	def self.valid?(value)
		value.nil? ? false : true
	end
end
