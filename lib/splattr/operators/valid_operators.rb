require 'splattr/operators'
require 'splattr/operators/validatable'

module Splattr
	module Operators
		class ValidOperators
			extend Validatable

=begin rdoc
Returns an Array of all valid Splattr operators.

WARNING: Any additions or deletions to any Splattr operators must be
reflected in the below method.
=end
			def self.valid_operators
				operators = []
				operators.concat Splattr::Operators::BitwiseOperator.valid_operators
				operators.concat Splattr::Operators::CompareOperator.valid_operators
			end
		end
	end
end
