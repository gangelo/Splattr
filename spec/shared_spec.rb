autoload :Age, 'modules/age'

# Thingy
shared_examples_for "thingy" do
	it_should_behave_like "names"
	it_should_behave_like "ages"
end

# Creature
shared_examples_for "creature" do
	it_should_behave_like "thingy"	
	it_should_behave_like "gender"
end

# Male
shared_examples_for "male person" do
	it_should_behave_like "creature"
	it_should_behave_like "male gender"
end

# Female
shared_examples_for "female person" do
	it_should_behave_like "creature"
	it_should_behave_like "female gender"
end

# Name
shared_examples_for "names" do
  context "name" do
		it "should respond_to? :name" do
			#p "Name: #{@it.name}"
			@it.respond_to?(:name).should == true
		end
		
		it "should not be nil?" do
			@it.name.nil?.should_not == true
		end

		it "should not be empty?" do
			@it.name.empty?.should_not == true
		end
	end
end

# Age
shared_examples_for "ages" do
	describe "age" do
		it "should be valid age" do
			Age.valid?(@it.age).should == true
		end
	end
end

# Gender
shared_examples_for "gender" do
	describe "gender" do
		it "should respond_to? :gender" do
			@it.respond_to?(:gender).should == true
		end

		it "should respond_to? :male?" do
			@it.respond_to?(:male?).should == true
		end

		it "should respond_to? :female?" do
			@it.respond_to?(:female?).should == true
		end

		it "should be Gender::MALE or Gender::FEMALE" do
			(@it.gender == Gender::MALE || @it.gender == Gender::FEMALE).should == true
			(@it.male? || @it.female?).should == true
		end
	end
end

shared_examples_for "male gender" do
	describe "male gender" do
		it "should be male" do
			(@it.gender == Gender::MALE && @it.male?).should == true
		end
	end
end

shared_examples_for "female gender" do
	describe "female gender" do		
		it "should be Gender::FEMALE" do			
			(@it.gender == Gender::FEMALE && @it.female?).should == true
		end
	end
end
