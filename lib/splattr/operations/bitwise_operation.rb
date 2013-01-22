require 'splattr/operations/base_operation'

module Splattr
	module Operations
		class BitwiseOperation < BaseOperation
			def self.valid_operations
				[:and,:or,:left_shift,:right_shift,:ones_compliment,:xor]
			end
		end
	end
end
