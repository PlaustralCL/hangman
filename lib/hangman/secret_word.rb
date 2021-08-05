# frozen_string_literal: true

module Hangman
  # Generate the secret word from the dictionary file
  class SecretWord
    attr_reader :word, :dictionary

    def initialize(word = new_word)
      @word = word
    end

    def new_word
      loop do
        @dictionary = File.readlines("5desk.txt")
        @dictionary = dictionary.map(&:chomp)
        word = dictionary.sample.downcase
        return word if word.length >= 5 && word.length <= 12
      end

    end

    def read_dictionary
      @dictionary = File.readlines("../../5desk.txt")
      @dictionary = @dictionary.map(&:chomp)
    end

  end
end

test_word = Hangman::SecretWord.new
p test_word.word
