require_relative '../lib/ppg'

require 'rspec'

describe PwGen do
	
	before(:each) do
		@pwgen = PwGen.new(8)
		@password = @pwgen.generate_password
	end

	it "should contain 8 digit password" do
		expect(@password.password.length).to eq(8)
	end
	it "should be of english chars, downcase" do 
		expect(@password.password).to match(/[a-z]+/)
	end

end