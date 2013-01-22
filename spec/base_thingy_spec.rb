# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'base/base_thingy'
require 'modules/gender'
require 'shared_spec.rb'

describe BaseThingy do
  before(:each) do
		params = [
			{:name=>'Tulip',:age=>25},
			{:name=>'Earth Worm',:age=>33},
			{:name=>'Mount Everest',:age=>10000},
			{:name=>'Oak Tree',:age=>105}
		].shuffle[0]
    @it = BaseThingy.new params[:name], params[:age]		
  end

	it_should_behave_like "thingy"
end