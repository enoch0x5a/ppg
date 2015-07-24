require_relative '../lib/ppg'
require 'rspec'

describe Phonemes do 
  phonemes = Phonemes.new
  it "should contain english phonemes by default" do
    expect(phonemes.phonemes).to eq($ENGLISH_PHONEMES_HASH)
  end
  it "should return [:vowel, :consonant, :dipthong]" do
    expect(phonemes.keys).to eq([:vowel, :consonant, :dipthong])
  end
  it "should return vowels Array" do
    expect(phonemes[:vowel]).to eq($ENGLISH_PHONEMES_HASH[:vowel])
  end
end
