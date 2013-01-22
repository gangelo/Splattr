# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'test/unit/assertions'

module Name
	class InvalidNameException < StandardError;	end
  attr_accessor :name

	def name=(value)
		raise Name::InvalidNameException.new('name cannot be nil?, spaces or empty?') if value.nil? || value.empty?
		@name=value
	end	
end
