# frozen_string_literal: true

module Hangman
  # Generate the secret word from the dictionary file
  class SecretWord

    attr_reader :word

    def initialize(word = nil)
      @word = word
      new_word
    end

    def new_word
      loop do
        @word ||= dictionary.sample.downcase
        return word if word.length >= 5 && word.length <= 12
      end
    end

    private

    def dictionary
      dictionary_file = File.readlines("5desk.txt")
      dictionary_file.map(&:chomp)
    end
  end
end
