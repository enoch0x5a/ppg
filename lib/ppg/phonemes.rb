$ENGLISH_PHONEMES_HASH = {

  :vowels => [ "a","e","i","o","u" ],

  :consonants => [ "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n",
    "p", "r", "s", "t", "v", "w", "x", "y", "z" ],

  :dipthongs => { 
    :vowel => ["ae", "oh", "oo", "ah", "ai", "ee", "ei", "ie"],
    :consonant => ["ng", "gh", "ch", "ph", "qu", "sh", "th"] 
  }
 
}.freeze

$ENGLISH_DOWNCASE_REGEXP = /[a-z]/.freeze

class Phonemes
  attr_reader :downcase_regexp
  
  def initialize(
    vowels = nil,
    consonants = nil,
    dipthongs = nil,
    downcase_regexp = $ENGLISH_DOWNCASE_REGEXP
  )

    @phonemes = { :vowel => vowels || $ENGLISH_PHONEMES_HASH[:vowels], 
      :consonant => consonants || $ENGLISH_PHONEMES_HASH[:consonants], 
      :dipthong => dipthongs || $ENGLISH_PHONEMES_HASH[:dipthongs]
    }
    @downcase_regexp = downcase_regexp
  end

  def keys
    @phonemes.keys
  end

  def [](index)
    @phonemes[index]
  end
end
