# frozen_string_literal: true

module Hangman
  # Generate the secret word from the dictionary file
  class SecretWord
    attr_reader :dictionary, :word

    def initialize(word = nil)
      @dictionary = read_dictionary
      @word = word
    end

    def new_word
      loop do
        @word ||= dictionary.sample.downcase
        return word if word.length >= 5 && word.length <= 12
      end
    end

    def read_dictionary
      @dictionary = File.readlines("5desk.txt")
      @dictionary = @dictionary.map(&:chomp)
    end
  end
end
