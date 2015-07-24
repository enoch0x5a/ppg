Gem::Specification.new do |s|
  s.name        = 'ppg'
  s.version     = '0.0.2'
  s.date        = '2015-07-22'
  s.summary     = "Phonetic Password Generator"
  s.description = "A simple password generator with pronunciation in mind"
  s.authors     = ["enoch0x5a"]
  s.files       = ["lib/ppg/password.rb",
    "lib/ppg/phonemes.rb",
    "lib/ppg/pwgen.rb",
    "lib/ppg.rb"]
  s.executables << "ppg"
  s.license     = 'MIT'
end
