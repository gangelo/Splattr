# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'people/male'
require 'shared_spec.rb'

describe Male do
  before(:each) do		
    @it = Male.new %w{Gene Bill Henry Frank}.shuffle[0], [20, 19, 32, 36].shuffle[0]
  end
	
	it_should_behave_like "male person"
end