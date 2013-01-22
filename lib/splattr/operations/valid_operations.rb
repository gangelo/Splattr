require 'splattr/operations'
require 'splattr/operations/validatable'

module Splattr
	module Operations
		class ValidOperations
			extend Validatable

=begin rdoc
Returns an Array of all valid Splattr operations.

WARNING: Any additions or deletions to any Splattr operation must be
reflected in the below method.
=end
			def self.valid_operations
				operations = []
				operations.concat Splattr::Operations::BitwiseOperation.valid_operations
				operations.concat Splattr::Operations::CompareOperation.valid_operations
				operations.concat Splattr::Operations::LogicalOperation.valid_operations
			end
		end
	end
end
