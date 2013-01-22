require 'ostruct'
require 'test/unit/assertions'
#require 'rdoc/rdoc'

require 'splattr/constants'
require 'splattr/results'
require 'splattr/exceptions'
require 'splattr/operations'
require 'splattr/operators'

=begin rdoc
=end
module Splattr	
	include Splattr::Exceptions

	attr_accessor :ignore_validation

	def self.extended(base)
		base.ignore_validation=false
	end

=begin rdoc
Returns true if the resulting operations for _each_ object property comparison
returns *true*, otherwise, splattr returns false.

For instance, if each object property comparison returns *true* and
operation == :eq, splattr will return true; if each object property comparison returns *true* and
operation == :ne, splattr will return true.
=end	
	def splattr(operation,*argv,&block)
		do_splattr(operation,*argv,&block)
	end

	def do_splattr(operation,*argv,&block)
		if !@ignore_validation
			raise InvalidOperationException.new "Operation '#{operation}' is not a valid operation" \
				if !Splattr::Operations::ValidOperations.valid?(operation)
		end

=begin
		operation_call = case operation
			when Splattr::EQ:
				lambda{|object,hash| splattr_eq(object,hash)}
			when Splattr::NE:
				lambda{|object,hash| splattr_ne(object,hash)}
			when Splattr::LT:
				lambda{|object,hash| splattr_lt(object,hash)}
			end
=end
		
		hash=argv.pop
		objects=argv.flatten
		result=true

		objects.each {|object|
			hash.each {|property,operator|
				# This is nice, but WAY too slow: result_object = self.send("splattr_#{operation.to_s.downcase}",object,{property=>operator},&block)				
				# This is a little too slow also: result_object=operation_call.call(object,{property=>operator},&block)

				result_object = case operation
				when Splattr::EQ:
					splattr_eq(object,{property=>operator},&block)
				when Splattr::NE:
					splattr_ne(object,{property=>operator},&block)
				when Splattr::LT:
					splattr_lt(object,{property=>operator},&block)
				end

				result = false if result && !result_object.result
			}
		}

		Result.new operation, result
	end
	protected :do_splattr

=begin rdoc
Shorthand for splattr(:eq,*argv,&block)

Returns true or false based on the resulting operations for
_each_ object property comparison.

If each object property comparison is *true*, splattr_eq will return true, otherwise
eq? will return false.
=end
	def splattr_eq(*argv,&block)
		hash=argv.pop
		objects=argv.flatten
		result=true
	
		objects.each {|object|
			hash.each {|property,operator|
				if !@ignore_validation
					# Valid operators and Procs pass
					raise InvalidOperatorException.new "Operator '#{operator}' is not a valid operator" \
						unless (Splattr::Operators::ValidOperators.valid?(operator) || operator.is_a?(Proc))
				end
				match=Splattr::Helpers::actual_result(self,object,property,operator)
				result_object=OperationResult.new Splattr::EQ,self,object,property,operator,match				
				
				if block_given?
					yield self, result_object
				end

				result = false if result && !match
			}
		}

		Result.new Splattr::EQ, result
	end

=begin rdoc
Shorthand for splattr(:ne,*argv,&block)

Returns true or false based on the resulting operations for
_each_ object property comparison.

If each object property comparison is *false*, splattr_ne will return true, otherwise
ne? will return false.
=end
	def splattr_ne(*argv,&block)
		result_object = splattr_eq(*argv) do |this,operation_result|
			# Gotta modify the operation as splattr_eq will set
			# OperationResult#operation's property to :eq!
			operation_result.operation=Splattr::NE
			block_given? ? (yield this,operation_result) : operation_result
		end		
		Result.new Splattr::NE, result_object.result==false
	end

=begin rdoc
Shorthand for splattr(:lt,*argv,&block)

Returns true if the resulting operations for _each_ object property comparison
have _less_ in common that not.
=end
	def splattr_lt(*argv,&block)
		compare_count=Hash.new(0)		

		splattr_eq(*argv) do |this,result|
			compare_count[:eq] += 1 if result.result == true
			compare_count[:ne] += 1 if result.result == false		

			# Gotta modify the operation as splattr_eq will set
			# OperationResult#operation's property to :eq!
			result.operation=Splattr::LT
			block_given? ? (yield this,result) : result
		end
		
		Result.new Splattr::LT, compare_count[:ne] > compare_count[:eq]
	end

	module Helpers
=begin rdoc
Returns the boolean result of the operation performed.
=end
		def self.actual_result(object_a,object_b,property,operator)
			return operator.call(object_a.send(property), object_b.send(property)) if operator.is_a? Proc
			return object_a.send(property) == object_b.send(property) if operator == Splattr::EQ
			return object_a.send(property) != object_b.send(property) if operator == Splattr::NE
			# TODO: Gotta raise an error here
		end
	end
end
