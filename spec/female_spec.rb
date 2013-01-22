# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'people/female'
require 'shared_spec.rb'

describe Female do
  before(:each) do		
    @it = Female.new %w{Amy Chloe Sharon Joanne}.shuffle[0], [20, 19, 32, 36].shuffle[0]
  end

	it_should_behave_like "female person"
end