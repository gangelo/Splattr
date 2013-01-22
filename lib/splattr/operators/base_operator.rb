require 'splattr/operators/operator'

module Splattr::Operators	
	class BaseOperator
		include Operator
		extend Validatable

		def initialize(operator)
			self.operator=operator
		end
	end
end

