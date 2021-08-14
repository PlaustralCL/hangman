# frozen_string_literal: true

module Hangman
  # Track the cipher
  class Cipher
    attr_reader :cipher, :secret_word

    def initialize(secret_word, cipher = nil)
      @secret_word = secret_word
      @cipher = cipher
      _cipher
    end

    def update_cipher(letter)
      indicies = find_indicies(letter)
      indicies.each do |index|
        # Multiply by 2 to account for the blank space between letters
        @cipher[index * 2] = letter
      end
    end

    def show_cipher
      cipher.join
    end

    def solved?
      cipher.none?("_")
    end

    private

    def _cipher
      @cipher ||= []
      blank_cipher if cipher.length.zero?
    end

    def blank_cipher
      secret_word.split("").each do
        cipher.push("_")
        cipher.push(" ")
      end
    end

    def find_indicies(letter)
      word = secret_word.chars
      word.each_index.select { |index| word[index] == letter }
    end
  end
end
