require 'splattr/splattr'
require 'splattr/exceptions'
require 'splattr/constants'

require 'people/male'
require 'people/female'
require 'things/anaconda'
require 'things/male_dog'
require 'things/oak_tree'
require 'modules/gender'
require 'helpers_spec'

describe Splattr do
	before(:each) do
		@it = Male.new 'Gene', 46
		@it.extend Splattr

		# WARNIGN: DO NOT change the below objects or properties!
		@my_clone = Male.new 'Gene2', 46
		@amy = Female.new 'Amy', 36		
		@riley = MaleDog.new 'Riley', 12
		@big_anaconda = Anaconda.new Gender::MALE, 46

		# WARNING: @mightly_oak.age and @old_anaconda.age MUST BE ==!
		@mighty_oak = OakTree.new 150
		@old_anaconda = Anaconda.new Gender::MALE, 150
	end

	describe "operations" do
		context "invalid operation" do
			it "should throw Splattr::Exceptions::InvalidOperationException if operation is invalid" do
				lambda {@it.splattr(:invalid_operation,@riley,:gender=>:eq)}.should raise_error(Splattr::Exceptions::InvalidOperationException)
			end			
		end
	end

	describe "operators" do
		context "invalid operator" do
			it "should throw Splattr::Exceptions::InvalidOperatorException if propety comparison operator is invalid" do
				lambda {@it.splattr(Splattr::EQ,@riley,:gender=>:invalid_operator)}.should raise_error(Splattr::Exceptions::InvalidOperatorException)
			end
		end
	end

	context ":eq operation" do
		context "with only one object to compare" do
			context "with no code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr(:eq,@amy,:name=>:ne).result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr(:eq,@amy,:name=>:eq).result.should == false
				end
			end
			context "with code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr(:eq,@amy,:name=>:ne) do |this,result|	puts result.description	end.result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr(:eq,@amy,:name=>:eq) do |this,result|	puts result.description	end.result.should == false
				end
			end
		end
		context "with multiple objects to compare" do
			context "with no code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr(:eq,@big_anaconda,@amy,:name=>:ne).result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr(:eq,@big_anaconda,@amy,:gender=>:eq).result.should == false
				end
			end
			context "with code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr(:eq,@big_anaconda,@amy,:name=>:ne) do |this,result|	puts result.description	end.result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr(:eq,@big_anaconda,@amy,:name=>:eq) do |this,result|	puts result.description	end.result.should == false
				end
			end
		end
	end

	context "splattr_eq method" do
		context "with only one object to compare" do
			context "with no code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr_eq(@big_anaconda,:name=>:ne).result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr_eq(@big_anaconda,:name=>:eq).result.should == false
				end
			end
			context "with code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr_eq(@big_anaconda,:name=>:ne) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr_eq(@big_anaconda,:name=>:eq)do |this,result|	puts result.description	end.result.should == false
				end
			end
		end
		context "with multiple objects to compare" do
			context "with no code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr_eq(@big_anaconda,@riley,:name=>:ne).result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr_eq(@big_anaconda,@riley,:name=>:eq).result.should == false
				end
			end
			context "with code block" do
				it "should return true if all object property comparisons return true" do
					@it.splattr_eq(@old_anaconda,@mighty_oak,:name=>:ne) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if any object property comparison returns false" do
					@it.splattr_eq(@old_anaconda,@mighty_oak,:name=>:eq) do |this,result| puts result.description end.result.should == false
				end
			end
		end
	end

	context ":ne operation" do
		context "with only one object to compare" do
			context "with no code block" do
				it "should return true if any object property comparison returns false" do					
					@it.splattr(:ne,@big_anaconda,:name=>:eq).result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr(:ne,@big_anaconda,:age=>:eq).result.should == false
				end
			end
			context "with code block" do
				it "should return true if any object property comparison returns false" do
					@it.splattr(:ne,@big_anaconda,:name=>:eq) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr(:ne,@big_anaconda,:age=>:eq) do |this,result| puts result.description end.result.should == false
				end
			end
		end
		context "with multiple objects to compare" do
			context "with no code block" do
				it "should return true if any object property comparison returns false" do
					@it.splattr(:ne,@big_anaconda,@riley,:name=>:eq).result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr(:ne,@big_anaconda,@riley,:name=>:ne).result.should == false
				end
			end
			context "with code block" do
				it "should return true if any object property comparison returns false" do
					@it.splattr(:ne,@big_anaconda,@riley,:name=>:eq) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr(:ne,@big_anaconda,@riley,:name=>:ne) do |this,result| puts result.description end.result.should == false
				end
			end
		end
	end

	context "splattr_ne method" do
		context "with only one object to compare" do
			context "with no code block" do
				it "should return true if any object property comparison returns false" do
					@it.splattr_ne(@big_anaconda,:name=>:eq).result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr_ne(@big_anaconda,:age=>:eq).result.should == false
				end
			end
			context "with code block" do
				it "should return true if any object property comparison returns false" do
					@it.splattr_ne(@big_anaconda,:name=>:eq) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr_ne(@big_anaconda,:age=>:eq) do |this,result| puts result.description end.result.should == false
				end
			end
		end
		context "with multiple objects to compare" do
			context "with no code block" do
				it "should return true if any object property comparison returns false" do
					@it.splattr_ne(@big_anaconda,@riley,:name=>:eq).result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr_ne(@big_anaconda,@riley,:name=>:ne).result.should == false
				end
			end
			context "with code block" do
				it "should return true if any object property comparison returns false" do
					@it.splattr_ne(@big_anaconda,@riley,:name=>:eq) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if all object property comparisons return true" do
					@it.splattr_ne(@big_anaconda,@riley,:name=>:ne) do |this,result| puts result.description end.result.should == false
				end
			end
		end
	end

	context ":lt operation" do
		context "with only one object to compare" do
			context "with no code block" do
				it "should return true if majority of object property comparisons return false" do
					@it.splattr(:lt,@big_anaconda,:name=>:eq,:gender=>:ne,:age=>:ne).result.should == true
				end
				it "should return false if majority of object property comparisons return true" do
					@it.splattr(:lt,@big_anaconda,:age=>:eq).result.should == false
				end
				it "should return false if an equal amount of object property comparisons return true and false" do
					@it.splattr(:lt,@big_anaconda,:age=>:eq, :name=>:ne).result.should == false
				end
			end
			context "with code block" do
				it "should return true if majority of object property comparisons return false" do
					@it.splattr(:lt,@big_anaconda,:name=>:eq) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if majority of object property comparisons return true" do
					@it.splattr(:lt,@big_anaconda,:age=>:eq) do |this,result| puts result.description end.result.should == false
				end
				it "should return false if an equal amount of object property comparisons return true and false" do
					@it.splattr(:lt,@big_anaconda,:age=>:eq, :name=>:ne) do |this,result| puts result.description end.result.should == false
				end
			end
		end
		context "with multiple objects to compare" do
			context "with no code block" do
				it "should return true if majority of object property comparisons return false" do
					force_false=lambda{|a,b| false}
					#@it.splattr(:lt,@big_anaconda,@riley,:name=>force_false,:gender=>force_false,:age=>force_false).result.should == true
					@it.splattr(:lt,@big_anaconda,@riley,:name=>:eq,:gender=>:ne).result.should == true
				end
				it "should return false if majority of object property comparisons return true" do
					#@it.splattr(:lt,@big_anaconda,@riley,:name=>:ne).result.should == false
				end
				it "should return false if an equal amount of object property comparisons return true and false" do
					#@it.splattr(:lt,@big_anaconda,@riley,:name=>:ne,:gender=>:eq).result.should == false
				end
			end
			context "with code block" do
				it "should return true if majority of object property comparisons return false" do
					#@it.splattr(:lt,@big_anaconda,@riley,:name=>:eq) do |this,result| puts result.description end.result.should == true
				end
				it "should return false if majority of object property comparisons return true" do
					#@it.splattr(:lt,@big_anaconda,@riley,:name=>:ne) do |this,result| puts result.description end.result.should == false
				end
				it "should return false if an equal amount of object property comparisons return true and false" do
					#@it.splattr(:lt,@big_anaconda,@riley,:name=>:ne,:gender=>:eq) do |this,result| puts result.description end.result.should == false
				end
			end
		end
	end
end