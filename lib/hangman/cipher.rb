# frozen_string_literal: true

module Hangman
  # Track the cipher
  class Cipher
    attr_reader :cipher, :secret_word

    def initialize(secret_word)
      @secret_word = secret_word
      @cipher = []
    end

    def blank_cipher
      secret_word.split("").each do
        cipher.push("_")
        cipher.push(" ")
      end
      cipher.join
    end

    def update_cipher(letter)
      indicies = find_indicies(letter)
      indicies.each do |index|
        @cipher[index * 2] = letter
      end
      cipher.join
    end

    def find_indicies(letter)
      indicies = []
      secret_word.split("").each_with_index do |ltr, index|
        indicies.push(index) if ltr == letter
      end
      indicies
    end


  end
end
