# frozen_string_literal: true

module Hangman
  # Generate the secret word from the dictionary file
  class SecretWord
    private

    attr_reader :filename

    public

    attr_reader :word

    def initialize(word = nil)
      @filename = "5desk.txt"
      @word = word
      new_word
    end

    def new_word
      loop do
        @word ||= dictionary.sample.downcase
        return word if word_length >= 5 && word_length <= 12

        # it is necessary to reset @word if it doesn't meet the criteria
        # otherwise it will end up in an endless loop.
        @word = nil
      end
    end

    private

    def dictionary
      dictionary_file = File.readlines(filename)
      dictionary_file.map(&:chomp)
    end

    def word_length
      word.length
    end
  end
end
