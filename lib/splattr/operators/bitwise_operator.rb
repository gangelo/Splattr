require 'splattr/operators/validatable'
require 'splattr/operators/base_operator'
require 'splattr/exceptions'

module Splattr::Operators
	class BitwiseOperator < BaseOperator
		extend Validatable

		def initialize(operator)
			super operator
		end

		def operator=(value)
			raise Splattr::Exceptions::InvalidOperatorException.new "Operator '#{value}' is not a valid bitwise operator" if !BitwiseOperator.valid? value
			super value
		end

		def self.valid_operators
			[:and,:or,:xor,:ones_compliment,:left_shift,:right_shift]
		end
	end
end
