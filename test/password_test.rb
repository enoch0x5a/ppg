require_relative '../lib/ppg'

require 'rspec'

describe Password do
  pwd = Password.new(8)
  it "should change length to 10" do
    pwd.length = 10
    expect(pwd.PASSWORD_LENGTH).to eq(10)
  end
  it "should raise exception x < 0 in .length=(x)" do
    expect { pwd.length = -1 }.to raise_error(ArgumentError,
      "length must be > 0")
  end
end