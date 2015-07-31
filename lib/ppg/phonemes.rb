$ENGLISH_PHONEMES_HASH = {

  :vowel => [ "a","e","i","o","u" ],

  :consonant => [ "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n",
    "p", "r", "s", "t", "v", "w", "x", "y", "z" ],

  :dipthong => { 
    :vowel => ["ae", "oh", "oo", "ah", "ai", "ee", "ei", "ie"],
    :consonant => ["ng", "gh", "ch", "ph", "qu", "sh", "th"] 
  }
 
}.freeze

$ENGLISH_DOWNCASE_REGEXP = /[a-z]/.freeze

class Phonemes
  attr_reader :downcase_regexp, :phonemes, :dipthong_length
  
  def initialize(
    vowels = nil,
    consonants = nil,
    dipthongs = nil,
    downcase_regexp = $ENGLISH_DOWNCASE_REGEXP
  )

    @phonemes = { :vowel => vowels || $ENGLISH_PHONEMES_HASH[:vowel], 
      :consonant => consonants || $ENGLISH_PHONEMES_HASH[:consonant], 
      :dipthong => dipthongs || $ENGLISH_PHONEMES_HASH[:dipthong]
    }
    @downcase_regexp = downcase_regexp
    @dipthong_length = 2
  end

  def keys
    @phonemes.keys
  end

  def [](index)
    @phonemes[index]
  end
end
