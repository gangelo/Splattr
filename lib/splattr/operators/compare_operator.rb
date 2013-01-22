require 'splattr/operators/validatable'
require 'splattr/operators/base_operator'
require 'splattr/exceptions'

module Splattr::Operators
	class CompareOperator < BaseOperator
		extend Validatable

		def initialize(operator)
			super operator
		end

		def operator=(value)
			raise Splattr::Exceptions::InvalidOperatorException.new "Operator '#{value}' is not a valid comparison operator" if !CompareOperator.valid? value
			super value
		end

		def self.valid_operators
			[:eq,:ne]
		end
	end
end