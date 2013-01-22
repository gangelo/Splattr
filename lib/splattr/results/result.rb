module Splattr
=begin rdoc
=end
	class Result
		#attr_reader :result
		attr_accessor :operation, :result

		def initialize(operation,result=nil)
			@operation=operation
			@result=result
		end
	end
end