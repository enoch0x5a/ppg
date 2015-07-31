# -*- encoding: utf-8 -*-
require_relative 'password'
require_relative 'phonemes'

require 'securerandom'

class MutatorError < Exception; end

class PwGen
  attr_reader :phonemes

  def initialize(length, phonemes = nil)
    @length = length
    @phonemes = phonemes || Phonemes.new
  end

  def add_mutator(count, proc)
    @mutators ||= {}
    @mutated_chars ||= []
    @clean_chars_left ||= @length

    return false if count == 0

    if @clean_chars_left == 0
      count = 0
      raise MutatorError, "nothing left to mutate, rejecting!"
    end

    unless proc.respond_to? :call
      raise MutatorError, "mutator's not callable, rejecting!"
    end

    if count > @clean_chars_left
      error_string = "can't mutate #{count} characters, decreasing to #{@clean_chars_left}!\n"
      count = @clean_chars_left
      raise MutatorError, error_string
    end

    @clean_chars_left -= count
    @mutators[proc] = count
    true

  rescue MutatorError
    STDERR << $!.message
    retry
  end

  def generate
    password = Password.new(@length)
    password = generate_pattern(password)
    password = fill_in_pattern(password)
    if defined? @mutators
      mutate(password)
    else
      password
    end
  end

protected 
  def fill_in_pattern(password)
      raise ArgumentError unless password.kind_of?(Password)
      password.pattern.each do |pattern|
      if pattern.kind_of?(Symbol)
        elem = @phonemes[pattern][SecureRandom.random_number(@phonemes[pattern].length)]
      else pattern.kind_of?(Array)
        # most definitely is dipthong
        length = @phonemes[pattern[0]][pattern[1]].length
        elem = @phonemes[pattern[0]][pattern[1]][SecureRandom.random_number(length)]
      end
      password.password << elem
    end
    password
  end

  def generate_pattern(password)
    length_left = @length
    next_pattern = previous_pattern = nil
    can_be_next_patterns = @phonemes.keys
    selector_block = Proc.new { |pattern|
      pattern if pattern != next_pattern || pattern == :dipthong 
    }
    while length_left > 0 do
      loop do
        next_pattern = generate_random_pattern(can_be_next_patterns)
        break unless requirements_not_met?(next_pattern,
          previous_pattern, length_left)        
      end

      can_be_next_patterns.select! &selector_block

      can_be_next_patterns << previous_pattern if previous_pattern != nil

      if next_pattern == :dipthong
        if password.pattern.empty? #first element
          auxiliary_pattern = generate_random_pattern([:vowel, :consonant])
        else
          auxiliary_pattern = 
            case previous_pattern
            when :vowel then :consonant
            when :consonant then :vowel
            end
        end
        next_pattern = next_pattern, auxiliary_pattern
        can_be_next_patterns -= [auxiliary_pattern]
        length_left -= @phonemes.dipthong_length
        previous_pattern = auxiliary_pattern
      else
        length_left -= 1
        previous_pattern = next_pattern
      end
      password.pattern << next_pattern
    end
    password
  end

  def mutate(password)
    @mutators.each_pair do |mutator, count| 
      while count > 0
        loop do
          index = SecureRandom.random_number(password.PASSWORD_LENGTH)
          next unless password.password[index] =~ @phonemes.downcase_regexp
          password.password[index] = (mutator.call password.password[index])
          break
        end
        count -= 1
      end 
    end
    password
  end

  def requirements_not_met?(next_pattern, previous_pattern, length_left)
    return true if next_pattern == :dipthong && length_left < @phonemes.dipthong_length
    return true if next_pattern == previous_pattern
    false
  end

  def generate_random_pattern(patterns)
    patterns [ SecureRandom.random_number(patterns.length) ]
  end
end
