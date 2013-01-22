require 'splattr/operations/operateable'
require 'splattr/operations/validatable'

module Splattr
	module Operations
		class BaseOperation
			include Operateable
			extend Validatable

			def initialize(operation)
				self.operation=operation
			end
		end
	end
end